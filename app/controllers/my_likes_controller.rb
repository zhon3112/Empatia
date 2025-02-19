class MyLikesController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.joins(:likes).where(likes: { user_id: current_user.id }).eager_load(:likes)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
