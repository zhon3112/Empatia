class LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: params[:post_id], like_type: params[:like_type])
    @like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: params[:post_id], like_type: params[:like_type])
    @like.destroy
  end
end
