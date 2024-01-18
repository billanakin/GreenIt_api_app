class Signin < ActiveType::Object
  attr_reader :user, :auth_token

  attribute :email, :string
  attribute :password, :string

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  validate :email_password_exists_validation

  after_save :set_auth_token

  def as_json(options = {})
    {
      user: @user.as_json(only: %i[id email first_name last_name]),
      auth_token: auth_token
    }
  end

  private

  def email_password_exists_validation
    return if errors[:email].present?
    return if errors[:password].present?

    @user = User.find_by(email: email)
    
    return if @user.present? && @user.authenticate_password(password)

    @user = nil

    errors.add(:base, "Invalid email/password combination.")
  end

  def set_auth_token
    @auth_token = JwtToken.encode({ user_id: @user.id })
  end
end
