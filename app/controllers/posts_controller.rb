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
      redirect_to user_path(current_user), notice: @post.published? ? '公開で投稿されました！' : '非公開で投稿されました！'
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      redirect_to user_path(current_user), alert: "投稿が見つかりませんでした"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      if @post.saved_change_to_status? || @post.saved_change_to_content?
        notice_message = if @post.saved_change_to_content?
                           '投稿を編集しました'
                         else
                           @post.published? ? '公開に変更されました' : '非公開に変更されました'
                         end
        redirect_to user_path(current_user), notice: notice_message
      else
        redirect_to user_path(current_user), notice: '変更はありませんでした'
      end
    else
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
