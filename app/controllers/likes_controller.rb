class LikesController < ApplicationController
  before_action :require_login

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
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: params[:post_id], like_type: params[:like_type])

    if @like
      @like.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'いいねを取り消しました！' }
      end
    else
      logger.error "Like not found for user #{current_user.id} with post_id #{params[:post_id]} and like_type #{params[:like_type]}"
      head :not_found
    end
  end

  # def create
  #   @post = Post.find(params[:post_id])
  #   @like = current_user.likes.new(post_id: params[:post_id], like_type: params[:like_type])
  #   if @like.save
  #     respond_to do |format|
  #       format.turbo_stream
  #       format.html { redirect_to @post, notice: 'いいねしました！' }
  #     end
  #   end
  # end

  # def destroy
  #   @post = Post.find(params[:post_id])
  #   @like = current_user.likes.find_by(post_id: params[:post_id], like_type: params[:like_type])
  #   @like.destroy
  # end
end
