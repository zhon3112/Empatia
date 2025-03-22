class PostsController < ApplicationController
  before_action :require_login
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).eager_load(:user, :likes).published.where.not(user_id: current_user.id).order(created_at: :desc)
    @likes_by_post = Like.where(post_id: @posts.map(&:id)).group_by(&:post_id) # 投稿ごとの全いいね数を事前に取得
    @user_likes = Like.where(user_id: current_user.id, post_id: @posts.map(&:id)).group_by(&:post_id) # ユーザーがいいねしたデータを事前取得
    @message = @posts.empty? ? "検索結果はありませんでした" : nil
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = @post.published? ? '公開で投稿されました！' : '非公開で投稿されました！'
      redirect_to my_posts_path(current_user)
    else
      flash.now[:alert] = "投稿が失敗しました！"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      redirect_to my_posts_path(current_user), alert: "投稿が見つかりませんでした"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      if @post.saved_change_to_status? || @post.saved_change_to_content?
        flash[:notice] = if @post.saved_change_to_content?
                           '投稿を編集しました'
                         else
                           @post.published? ? '公開に変更されました' : '非公開に変更されました'
                         end
      else
        flash[:notice] = '変更はありませんでした'
      end
      redirect_to my_posts_path(current_user)
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      redirect_to my_posts_path(current_user), notice: "投稿が削除されました"
    end
  end

  private

  # 不正アクセスを防ぐ
  def ensure_correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      flash[:alert] = "権限がありません、不正アクセスです！"
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:content, :status, :id)# postパラメーターの中から必要な属性を許可する
  end
end
