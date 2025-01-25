class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :like_type, presence: true

  enum like_type: {}
end
