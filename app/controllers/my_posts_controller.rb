class MyPostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.where(user_id: current_user.id)
    @message = @posts.empty? ? "あなたの投稿はありません" : nil
  end
end
