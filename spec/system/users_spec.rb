require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザーの新規作成が成功する" do
          visit new_user_path
          fill_in "ユーザー名", with: "test1"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード確認", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザーが作成されました"
          expect(current_path).to eq posts_path
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "ユーザー名", with: "test1"
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: "password"
          fill_in "パスワード確認", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq users_path
        end
      end

      context "登録済のメールアドレスを使用" do
        it "ユーザーの新規作成が失敗する" do
          existed_user = create(:user, email: "email@example.com")
          visit new_user_path
          fill_in "ユーザー名", with: "test1"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_content "メールアドレス：このメールアドレスは登録済みです"
          expect(current_path).to eq users_path
          expect(page).to have_field "メールアドレス", with: "email@example.com"
        end
      end
    end

    describe "投稿一覧遷移" do
      context "ログインしていない状態" do
        it "投稿一覧ページへのアクセスが失敗する" do
          visit posts_path(user)
          expect(page).to have_content "ログインしてください"
          expect(current_path).to eq login_path
        end
      end
    end
  end
end