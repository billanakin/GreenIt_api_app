class UserPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @pagy, @posts = pagy(user.posts)
  end

  def commented
    @pagy, @commented_posts = pagy(user.commented_posts)
  end

  def shared
    @pagy, @shared_posts = pagy(user.shared_posts)
  end

  def liked
    @pagy, @liked_me_posts = pagy(user.liked_posts)
  end

  private

  def user_id_param
    params.require(:user_id)
  end

  def user
    @user
  end

  def set_user
    @user =
      if user_id_param == 'me'
        current_user
      else
        User.find(user_id_param)
      end
  end
end
