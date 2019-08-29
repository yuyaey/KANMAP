class ItemIcon < ApplicationRecord
  mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: {maximum: 30}

  has_many :items, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
end
