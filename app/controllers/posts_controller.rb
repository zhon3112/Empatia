class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.limit(20)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: '投稿が作成されました！'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました！'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました！'
  end
end

private

  def post_params
    params.require(:post).permit(:content, :status)
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end
end
