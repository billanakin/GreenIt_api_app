class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :ensure_current_user, only: %i[update]

  def show
  end

  def update
    @user = current_user
    if @user.update(update_params)
      render :update
    else
      render :update_errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:user).permit(
      :first_name,
      :last_name
    )
  end

  def set_user
    @user =
      if params[:id] == 'me'
        current_user
      else
        User.find(params[:id])
      end
  end

  def ensure_current_user
    return if current_user?(@user)

    head :unauthorized
  end
end
