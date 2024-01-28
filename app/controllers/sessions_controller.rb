class SessionsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]

  def create
    signin = Signin.new(signin_params)
    if signin.save
      render json: { data: signin }
    else
      render json: { data: signin.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    signout = Signout.new(auth_token: current_user_auth_token)
    if signout.save
      render json: { data: signout }
    else
      render json: { data: signout.errors }, status: :unprocessable_entity
    end
  end

  private

  def signin_params
    params.permit(:email, :password)
  end
end
  