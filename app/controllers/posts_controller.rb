class PostsController < ApplicationController
  before_action :require_login

  def index
    @user = current_user #自分
    @post = @user.posts.build # 新規投稿用
    @q = Post.ransack(params[:q])

    if params[:q].present?
      @posts = @q.result(distinct: true).where.not(user_id: @user.id)
    else
      @posts = Post.where.not(user_id: @user.id)
    end
    @message = @posts.empty? ? "検索結果はありませんでした" : nil # 検索結果が空の場合のメッセージ
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
      redirect_to user_path(current_user), notice: '投稿が作成されました！'
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
      redirect_to user_path(current_user), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:uuid])
    @post.destroy
    redirect_to user_path(current_user), notice: '投稿が削除されました！'
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :status)
  end
end
