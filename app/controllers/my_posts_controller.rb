class MyPostsController < ApplicationController
  def index
    @post = Post.new
    @posts = current_user.posts.eager_load(:likes)
    @likes_by_post = Like.where(post_id: @posts.map(&:id)).group_by(&:post_id)
    @message = @posts.empty? ? "あなたの投稿はありません" : nil
    respond_to do |format|
      format.html
      format.js
      format.turbo_stream
    end
  end
end