class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create from_friends]

  def trending
    @pagy, @trending_posts = pagy(Post.trending)
  end

  def near_me
    @pagy, @near_me_posts = pagy(Post.near(near_me_current_location_param, near_me_distance_in_miles_param))
  end

  def latest
    @pagy, @latest_posts = pagy(Post.latest)
  end

  def recommended
    @pagy, @recommended_posts = pagy(Post.recommended)
  end

  def from_friends
    @pagy, @from_friends_posts = pagy(Post.from_friends(current_user))
  end

  def create
    @create_form = Post::CreateForm.new(create_param)
    @create_form.user = current_user
    if @create_form.save
      render :create
    else
      render :create_errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
  end

  private

  def create_param
    params.require(:post).permit(
      :title,
      :body,
      :latitude,
      :longitude,
      :address,
      images: %i[rank data_uri]
    )
  end

  def near_me_current_location_param
    [params.require(:latitude), params.require(:longitude)]
  end

  def near_me_distance_in_miles_param
    params[:distance_in_miles] || Post::DEFAULT_NEAR_ME_DISTANCE_IN_MILES
  end
end
