class SessionsController < ApplicationController
  before_action :authenticate_user!, only: %i[show destroy]

  def show
    render :show
  end

  def create
    @signin_form = SigninForm.new(signin_params)
    if @signin_form.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @signout_form = SignoutForm.new(auth_token: current_user_auth_token)

    @signout_form.save!
  end

  private

  def signin_params
    params.permit(:email, :password)
  end
end
  