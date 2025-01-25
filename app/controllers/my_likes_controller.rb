class MyLikesController < ApplicationController
  before_action :require_login

  def index
    @likes = current_user.likes.includes(:post).order(created_at: :desc)
  end
end
