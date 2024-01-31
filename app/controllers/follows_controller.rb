class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @follow = current_user.followings.build(create_params)
    if @follow.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @follow = current_user.followings.find(params[:id])
    @follow.destroy!
  end

  private

  def create_params
    params.require(:follow).permit(
      :to_user_id
    )
  end
end
