class SignoutForm < ActiveType::Object
  attr_reader :invalidated_payload

  attribute :auth_token

  validates :auth_token, presence: true

  after_save :invalidate_token

  def user
    user_id = invalidated_payload[:user_id]
    User.find_by(id: user_id)
  rescue StandardError
  end

  def success?
    !!invalidated_payload
  end

  private

  def invalidate_token
    @invalidated_payload = JwtToken.invalidate(auth_token)
  end
end
