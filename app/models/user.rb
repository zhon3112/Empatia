class User < ApplicationRecord
  authenticates_with_sorcery!
	has_many :authentications, dependent: :destroy
	accepts_nested_attributes_for :authentications
	has_many :likes, dependent: :destroy
	has_many :liked_posts, through: :likes, source: :post
	has_many :posts

	validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
	validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
	validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
	validates :username, presence: true, length: { maximum: 10 }
	validates :email, presence: true, uniqueness: true
	validates :terms_accepted, acceptance: { accept: true}
end
