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
    @post = current_user.posts.find(params[:post_uuid])
  end

  def update
    @post = current_user.posts.find(params[:post_uuid])
    if @post.update(post_params)
      redirect_to user_path(current_user), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  # def destroy
  #   @post = Post.find(params[:uuid])
  #   @post.destroy
  #   redirect_to user_path(current_user), notice: '投稿が削除されました！'
  # end

  private

  def post_params
    params.require(:post).permit(:content, :status)# postパラメーターの中から必要な属性を許可する
  end
end
