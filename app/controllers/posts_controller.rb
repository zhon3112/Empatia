class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.where.not(user_id: current_user.id) # 自分以外のみんなの投稿
    @user = current_user #自分
    @post = @user.posts.build # 新規投稿用
  end

  def show
    @post = Post.find(params[:uuid])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: '投稿が作成されました！'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:uuid])
  end

  def update
    @post = Post.find(params[:uuid])
    if @post.update(post_params)
      redirect_to user_posts_path(current_user), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:uuid])
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました！'
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :status)
  end
end
