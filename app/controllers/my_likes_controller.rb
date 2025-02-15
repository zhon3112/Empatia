class MyLikesController < ApplicationController
  before_action :require_login

  def index
    @posts = current_user.posts.eager_load(:likes)
    @user_likes = @posts.joins(:likes).group_by(&:id)
  end
end
