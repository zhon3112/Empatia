class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }

  enum status: { public: 0, private: 1 }

  def make_private
    update(status: :private)
  end
end
