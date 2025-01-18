class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def show
    @post = Post.new
    @posts = current_user.posts
  end

  def create
    @user = User.new(user_params)
    if @user.terms_accepted?
      if @user.save
        auto_login(@user)
        redirect_to posts_path, notice: "ユーザーが作成されました"
      else
        flash.now[:alert] = "パスワードは8文字で作成してください"
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "利用規約に同意する必要があります"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :terms_accepted)
  end
end
