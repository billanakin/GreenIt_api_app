class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_post

  def index
    @pagy, @comments = pagy(post.comments.order(created_at: :desc))
  end

  def create
    @comment = post.comments.build(create_params)
    @comment.user = current_user
    @comment.post = post
    if @comment.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = post.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def create_params
    params.require(:comment).permit(
      :body
    )
  end

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
