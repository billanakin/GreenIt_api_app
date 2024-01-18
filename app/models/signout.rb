class Signout < ActiveType::Object
  attr_reader :invalidated_payload

  attribute :auth_token

  validates :auth_token, presence: true

  after_save :invalidate_token

  def as_json(options={})
    hash = { token_invalidated: !!invalidated_payload }
    if !invalidated_payload.is_a?(FalseClass)
      user_id = invalidated_payload[:user_id]
      user = User.find_by(id: user_id)
      hash.merge!({ user: user.as_json(only: %i[id email first_name last_name]) }) if user.present?
    end
    hash
  end

  private

  def invalidate_token
    @invalidated_payload = JwtToken.invalidate(auth_token)
  end
end
