class JwtToken
  EXPIRE_AT = 1.month
  INVALIDATED_TOKENS_REDIS_KEY_PREFIX = "greenit:invalidatedtokens"

  class << self
    def encode(payload)
      hash = { payload: payload, expire_at: EXPIRE_AT.from_now, token_id: SecureRandom.hex }
      JWT.encode(hash, hmac_secret, 'HS256')
    end

    def decode(token)
      hash = decode_token(token)

      return nil if hash.nil?
      return nil if DateTime.now >= DateTime.parse(hash["expire_at"])
      return nil if invalidated?(hash["token_id"])

      return hash["payload"]&.with_indifferent_access
    end

    def invalidate(token)
      hash = decode_token(token)

      return false if hash.nil?

      token_id = hash["token_id"]
      expire_at = DateTime.parse(hash["expire_at"])

      $redis.set(redis_key(token_id), token_id)
      $redis.expire(redis_key(token_id), expire_at.to_i)

      return hash["payload"]&.with_indifferent_access
    end

    private

    def redis_key(token_id)
      "#{INVALIDATED_TOKENS_REDIS_KEY_PREFIX}:#{token_id}"
    end

    def decode_token(token)
      JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' }).first
    rescue JWT::DecodeError
      nil
    end

    def hmac_secret
      Rails.application.credentials.jwt.secret
    end

    def invalidated?(token_id)
      redis_token_id = $redis.get(redis_key(token_id))

      return false if redis_token_id.nil?

      $redis.del(redis_key(token_id))
    end
  end
end
