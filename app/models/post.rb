class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  enum status: { published: 0, unpublished: 1 }, _default: :published # 投稿のステータス(公開・非公開)

  scope :published, -> { where(status: :published) } # 公開の投稿だけを取得

  def self.ransackable_attributes(auth_object = nil)
    ["content"]
  end
end
