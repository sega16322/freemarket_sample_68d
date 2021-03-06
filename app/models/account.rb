class Account < ApplicationRecord
  mount_uploader :icon_image, ImageUploader
  mount_uploader :background_image, ImageUploader
  belongs_to :user

  validates :user_id, presence: true
  validates :introduction, length: { maximum: 1000 }
end
