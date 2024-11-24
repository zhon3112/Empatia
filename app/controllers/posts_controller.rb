class PostsController < ApplicationController
  before_action :require_login

  def index
    @user = current_user #自分
    @post = @user.posts.build # 新規投稿用
    Rails.logger.debug "Search Params: #{params[:q].inspect}" # 検索パラメータをログに出力
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).where.not(user_id: @user.id) # 自分以外のみんなの投稿
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

  def search
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).where.not(user_id: @user.id)

    if @posts.any?
      redirect_to posts_search_path(q: params[:q])
    else
      flash[:notice] = "検索結果がありませんでした"
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :status)
  end
end
