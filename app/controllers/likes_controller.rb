class LikesController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:create, :destroy]

  def create
    Rails.logger.debug "Params received: #{params.inspect}"
    Rails.logger.debug "Creating like for post_id: #{@post.id}, user_id: #{current_user.id}, like_type: #{params[:like_type]}"

    # 既に同じユーザーのいいねが存在するか確認
    @like = current_user.likes.find_or_initialize_by(post_id: @post.id, like_type: params[:like_type])
    Rails.logger.debug "Found like: #{@like.persisted? ? 'Already exists' : 'New like'}"

    if @like.persisted?
      Rails.logger.debug "Like already exists for post_id: #{@post.id}, user_id: #{current_user.id}"
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'すでにいいねしています。' }
      end
    else
      if @like.save
        Rails.logger.debug "Like saved successfully: #{@like.inspect}"
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to @post, notice: 'いいねしました！' }
        end
      else
        Rails.logger.error "Failed to save like: #{@like.errors.full_messages}"
        respond_to do |format|
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_to @post, alert: 'いいねに失敗しました。' }
        end
      end
    end
  end

  def destroy
    @like = @post.likes.find_by(like_type: params[:like_type], user: current_user)
    if @like
      Rails.logger.debug "Destroying like for post_id: #{@post.id}, user_id: #{current_user.id}, like_type: #{params[:like_type]}"
      @like.destroy
      Rails.logger.debug "Like successfully destroyed."
    else
      Rails.logger.warn "No like found to destroy for post_id: #{@post.id}, user_id: #{current_user.id}, like_type: #{params[:like_type]}"
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
