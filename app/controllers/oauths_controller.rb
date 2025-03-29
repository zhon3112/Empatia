class OauthsController < ApplicationController
  skip_before_action :require_login, only: %i[oauth callback]

  def oauth
    login_at(auth_params[:provider]) # 指定されたプロバイダの認証ページにユーザーをリダイレクト
  end

  def callback
    provider = auth_params[:provider]
    # 既存のユーザーをプロバイダ情報を元に検索、存在すればログイン
    if (@user = login_from(provider))
      redirect_to posts_path, success: "Googleアカウントでログインしました"
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成してログイン
        signup_and_login(provider)
        redirect_to posts_path, success: "Googleアカウントでログインしました"
      rescue
        redirect_to root_path, danger: "Googleアカウントでログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
