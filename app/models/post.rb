class Post < ApplicationRecord
  belongs_to :user
  include PrimaryKeyUuidAutoGeneratable

  validates :content, presence: true, length: { maximum: 140 }

  enum status: { visible: 0, is_public: 1 }

  def make_private
    update(status: :is_public)
  end
end
