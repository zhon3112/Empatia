class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content,invalid_words: true
  validates :content, presence: true, length: { maximum: 140 }

  enum status: { published: 0, unpublished: 1 }, _default: :published # 投稿のステータス(公開・非公開)

  scope :published, -> { where(status: :published) } # 公開の投稿だけを取得

  def self.ransackable_attributes(auth_object = nil)
    ["content"]
  end

  # いいねしているかどうかの判断
  def liked_by?(user, like_type)
    likes.any? { |like| like.user_id == user.id && like.like_type == like_type }
  end
end
