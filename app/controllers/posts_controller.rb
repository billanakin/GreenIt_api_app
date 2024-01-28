class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[near_me from_friends create]

  def trending
    @pagy, @trending_posts = pagy(Post.trending)
  end

  def near_me
    @pagy, @near_me_posts = pagy(Post.near_me(current_user_id))
  end

  def latest
    @pagy, @latest_posts = pagy(Post.latest)
  end

  def recommended
    @pagy, @recommended_posts = pagy(Post.recommended)
  end

  def from_friends
    @pagy, @from_friends_posts = pagy(Post.from_friends(current_user_id))
  end

  def create
    create_post_form = CreatePostForm.new(create_params)
    create_post_form.user = current_user
    if create_post_form.save
      render json: { data: create_post_form }
    else
      render json: { data: create_post_form.errors }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:post).permit(
      :title,
      :body,
      :latitude,
      :longitude,
      images: %i[rank data_uri]
    )
  end
end
