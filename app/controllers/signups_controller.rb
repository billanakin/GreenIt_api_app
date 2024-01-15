class SignupsController < ApplicationController
  def create
    signup = Signup.new(signup_params)
    if signup.save
      render json: { data: signup }
    else
      render json: { data: signup.errors }, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name
    )
  end
end
