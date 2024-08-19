class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }

  enum status: { visible: 0, is_public: 1 }

  def make_private
    update(status: :is_public)
  end
end
