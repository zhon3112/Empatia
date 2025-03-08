class User < ApplicationRecord
  authenticates_with_sorcery!
	has_many :authentications, dependent: :destroy
	accepts_nested_attributes_for :authentications
	has_many :likes, dependent: :destroy
	has_many :liked_posts, through: :likes, source: :post
	has_many :posts

	validates :password, length: { minimum: 8, message: "は8文字以上である必要があります" }, if: -> { new_record? || changes[:crypted_password] }
	validates :password, confirmation: { message: "が一致しません" }, if: -> { new_record? || changes[:crypted_password] }
	validates :password_confirmation, presence: { message: "を入力してください" }, if: -> { new_record? || changes[:crypted_password] }
	validates :username, presence: { message: "を入力してください" }, length: { maximum: 10, message: "は10文字以内である必要があります" }
	validates :email, presence: { message: "を入力してください" }, uniqueness: { message: "：このメールアドレスは登録済みです" }
	validates :terms_accepted, acceptance: { accept: true, message: "に同意する必要があります" }
end
