class Post < ApplicationRecord
  belongs_to :user
  # attribute :uuid, :string, default: -> { SecureRandom.uuid } #重複を避けたユニークなUUIDをstring型の属性として定義新しく作成されるオブジェクトには自動的に割り当てられる

  validates :content, presence: true, length: { maximum: 140 }

  enum status: { published: 0, unpublished: 1 }, _default: :published # 投稿のステータス(公開・非公開)

  scope :published, -> { where(status: :published) } # 公開の投稿だけを取得

  def self.ransackable_attributes(auth_object = nil)
    ["content"]
  end

	# def to_param
	# 	uuid
	# end
end
