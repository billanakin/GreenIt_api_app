class PostsController < ApplicationController
  def recent
    @pagy, @recent_posts = pagy(Post.recent)
  end
end
