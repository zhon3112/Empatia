class PostsController < ApplicationController
  before_action :require_login

  def index
    @q = Post.ransack(params[:q])

    if params[:q].present?
      @posts = @q.result(distinct: true).where.not(user_id: current_user.id)
    else
      @posts = Post.where.not(user_id: current_user.id)
    end
    @message = @posts.empty? ? "検索結果はありませんでした" : nil # 検索結果が空の場合のメッセージ
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_path(current_user), notice: '投稿が作成されました！'
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
    if @post.nil?
      redirect_to user_path(current_user), alert: "投稿が見つかりませんでした"
      puts
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to user_path(current_user), notice: "投稿を編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      redirect_to user_path(current_user), notice: "投稿が削除されました"
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :status, :id)# postパラメーターの中から必要な属性を許可する
  end
end
