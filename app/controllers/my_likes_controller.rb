class MyLikesController < ApplicationController
  before_action :require_login

  def index
    @posts = current_user.liked_posts.eager_load(:user, :likes).distinct
    @likes_by_post = Like.where(post_id: @posts.pluck(:id)).group_by(&:post_id)
  end
end
