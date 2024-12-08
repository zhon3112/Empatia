class Post < ApplicationRecord
  belongs_to :user
  # attribute :uuid, :string, default: -> { SecureRandom.uuid } #重複を避けたユニークなUUIDをstring型の属性として定義新しく作成されるオブジェクトには自動的に割り当てられる

  validates :content, presence: true, length: { maximum: 140 }

  enum status: { visible: 0, is_public: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["content"]
  end

  def make_private
    update(status: :is_public)
  end

	# def to_param
	# 	uuid
	# end
end
