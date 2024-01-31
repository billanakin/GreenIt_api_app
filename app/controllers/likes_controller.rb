class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = post.likes.build
    @like.user = current_user
    @like.post = post
    if @like.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @like = post.likes.find(params[:id])
    @like.destroy!
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
