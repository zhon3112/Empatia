class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :like_type, presence: true

  def self.group_by_post
    all.group_by(&:post_id)
  end
end
