class SignupForm < ActiveType::Record[User]

  validates :password_confirmation, presence: true, on: :create
end
