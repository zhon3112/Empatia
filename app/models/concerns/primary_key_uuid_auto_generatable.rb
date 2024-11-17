module PrimaryKeyUuidAutoGeneratable
  extend ActiveSupport::Concern

  included do
    before_create :generate_uuid
  end

  def generate_uuid
    return if self.id.present?

    self.id = SecureRandom.uuid
  end
end