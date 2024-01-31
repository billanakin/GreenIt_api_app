class SessionsController < ApplicationController
  before_action :authenticate_user!, only: %i[show destroy]

  def show
    render :show
  end

  def create
    @create_form = Session::CreateForm.new(signin_params)
    if @create_form.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @destroy_form = Session::DestroyForm.new(auth_token: current_user_auth_token)

    @destroy_form.save!
  end

  private

  def signin_params
    params.permit(:email, :password)
  end
end
  