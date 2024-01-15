class Signup < ActiveType::Record[User]

  validates :password_confirmation, presence: true, on: :create
  
  def as_json(options = {})
    super(only: %i[id email first_name last_name])
  end
end