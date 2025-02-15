class LikesController < ApplicationController
  before_action :require_login
  before_action :update_like_data, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_or_initialize_by(post_id: @post.id, like_type: params[:like_type])

    if @like.persisted?
      @like.destroy
      Rails.logger.debug "Like successfully destroyed."
    else
      if @like.save
        Rails.logger.debug "Like saved successfully"
      else
        Rails.logger.error "Failed to save like"
        return head :unprocessable_entity
      end
    end

    update_like_data

    respond_to do |format|
      format.turbo_stream { render "likes/create" } # **destroy の場合も create を使う**
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(like_type: params[:like_type], user: current_user)
    if @like
      @like.destroy
      Rails.logger.debug "Like successfully destroyed."
    else
      Rails.logger.warn "No like found to destroy."
    end

    # ここでデータを最新に更新
    update_like_data

    respond_to do |format|
      format.turbo_stream { render "likes/destroy" } # 明示的に `destroy.turbo_stream.erb` を指定
    end
  end

  private

  def update_like_data
    @user_likes = current_user.likes.group_by(&:post_id) # **ユーザーのいいねデータを更新**
    @likes_by_post = Like.group_by_post # **全体のいいねデータを更新**
  end
end
