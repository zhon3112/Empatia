class LikesController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    # 既に同じユーザーのいいねが存在するか確認
    @like = current_user.likes.find_or_initialize_by(post_id: @post.id, like_type: params[:like_type])
    if @like.persisted?
      # 既にいいねが存在する場合は何もしない
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'すでにいいねしています。' }
      end
    else
      if @like.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to @post, notice: 'いいねしました！' }
        end
      else
        respond_to do |format|
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_to @post, alert: 'いいねに失敗しました。' }
        end
      end
    end
  end

  def destroy
    @like = @post.likes.find_by(like_type: 'like_first', user: current_user)
    if @like
      @like.destroy
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to post_path(@post) }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
