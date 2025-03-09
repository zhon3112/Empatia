class MyPostsController < ApplicationController
  before_action :require_login

  def index
    @post = Post.new
    @posts = current_user.posts.eager_load(:likes)
    @likes_by_post = Like.where(post_id: @posts.map(&:id)).group_by(&:post_id)
    @message = @posts.empty? ? "あなたの投稿はありません" : nil
  end
end