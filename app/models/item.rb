class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: {maximum: 30}
  validates :kanzume, presence: true
  validates :item_icon, presence: true

  belongs_to :kanzume
  belongs_to :user
  belongs_to :item_icon

  scope :recent, -> { order(created_at: :desc) }
end
