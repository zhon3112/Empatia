class LikesController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: params[:post_id], like_type: params[:like_type])

    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'いいねしました！' }
      end
    else
      # 保存失敗時のエラーログ出力
      logger.error "Like creation failed: #{@like.errors.full_messages.join(', ')}"

      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to @post, alert: 'いいねに失敗しました。' }
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
