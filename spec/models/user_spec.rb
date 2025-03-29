require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

  describe 'バリデーションチェック' do
    it 'ユーザーが適切な情報を持っている場合は有効' do
      user.username = "username"
      user.email = "test@example.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.terms_accepted = true
      expect(user).to be_valid
    end

    it 'ユーザー名がない場合は無効' do
      user.email = "test@example.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.terms_accepted = true
      expect(user).to_not be_valid
    end

    it 'ユーザー名が10文字を超えると無効' do
      user.username = "longusername"
      user.email = "test@example.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.terms_accepted = true
      expect(user).to_not be_valid
    end

    it 'メールアドレスがない場合は無効' do
      user.username = "username"
      user.password = "password"
      user.password_confirmation = "password"
      user.terms_accepted = true
      expect(user).to_not be_valid
    end

    it 'メールアドレスが重複した場合は無効' do
      User.create(username: "user1", email: "test@example.com", password: "password", password_confirmation: "password", terms_accepted: true)
      user.username = "user2"
      user.email = "test@example.com"
      user.password = "password"
      user.password_confirmation = "password"
      user.terms_accepted = true
      expect(user).to_not be_valid
    end

    it 'パスワードが8文字未満の場合は無効' do
      user.username = "username"
      user.email = "test@example.com"
      user.password = "short"
      user.password_confirmation = "short"
      user.terms_accepted = true
      expect(user).to_not be_valid
    end

    it 'パスワードとパスワード確認が一致しない場合は無効' do
      user.username = "username"
      user.email = "test@example.com"
      user.password = "password"
      user.password_confirmation = "wrongpassword"
      user.terms_accepted = true
      expect(user).to_not be_valid
    end
  end
end
