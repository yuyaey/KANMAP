class KanzumeIcon < ApplicationRecord
  include FriendlyId
  friendly_id :name
  mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: {maximum: 30}

  has_many :kanzumes, dependent: :destroy



  scope :recent, -> { order(created_at: :desc) }
end
