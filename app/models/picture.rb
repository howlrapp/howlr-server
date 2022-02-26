class Picture < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :user, touch: true

  validates :picture, presence: true

  mount_base64_uploader :picture, PictureUploader, mount_on: :picture, file_name: -> (u) { SecureRandom.uuid }
end