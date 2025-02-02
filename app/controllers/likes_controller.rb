class LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: params[:post_id], like_type: params[:like_type])
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'いいねしました！' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: params[:post_id], like_type: params[:like_type])
    @like.destroy
  end
end
