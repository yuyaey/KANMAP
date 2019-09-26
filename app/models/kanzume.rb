class Kanzume < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  belongs_to :user
  has_many :items, dependent: :restrict_with_error
  belongs_to :kanzume_icon
  has_many :maps, dependent: :destroy
  accepts_nested_attributes_for :maps
  scope :recent, -> { order(created_at: :desc) }
  paginates_per 15
end

