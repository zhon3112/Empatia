class User < ApplicationRecord
  authenticates_with_sorcery!

	validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
	validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
	validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
	validates :password, format: { with: /(?=.*[A-Z])(?=.*[\W_])/, message: "には大文字と記号が必要です" }, if: -> { new_record? || changes[:crypted_password] }
	validates :username, presence: true, length: { maximum: 10 }
	validates :email, presence: true, uniqueness: true
end
