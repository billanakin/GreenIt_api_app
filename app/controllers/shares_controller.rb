class SharesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @share = post.shares.build
    @share.user = current_user
    @share.post = post
    if @share.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @share = post.shares.find(params[:id])
    @share.destroy!
  end

  private

  def post_id_param
    params.require(:post_id)
  end

  def post
    @post
  end

  def set_post
    @post = Post.find(post_id_param)
  end
end
