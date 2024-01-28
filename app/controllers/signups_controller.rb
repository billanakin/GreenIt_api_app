class SignupsController < ApplicationController
  def create
    @signup_form = SignupForm.new(signup_params)
    if @signup_form.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
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
