class User < ApplicationRecord
	authenticates_with_sorcery!
	has_many :posts
	attribute :uuid, :string, default: -> { SecureRandom.uuid }

	validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
	validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
	validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
	validates :username, presence: true, length: { maximum: 10 }
	validates :email, presence: true, uniqueness: true

	def to_param
		uuid
	end
end
