class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = login(params[:email], params[:password], params[:remember_me])

    if @user
      redirect_to posts_path, notice: "ログインしました"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    remember_me!
    forget_me!
    logout
    redirect_to root_path, status: :see_other
  end
end
