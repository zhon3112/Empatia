class Post < ApplicationRecord
  belongs_to :user
  attribute :uuid, :string, default: -> { SecureRandom.uuid }

  validates :content, presence: true, length: { maximum: 140 }

  enum status: { visible: 0, is_public: 1 }

  def make_private
    update(status: :is_public)
  end

  def to_param
    uuid
  end
end
