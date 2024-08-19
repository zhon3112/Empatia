class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }

  enum status: { visible: 0, is_private: 1 }

  def make_private
    update(status: :is_private)
  end
end
