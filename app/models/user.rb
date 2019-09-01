class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :items, dependent: :destroy
  has_many :kanzumes, dependent: :destroy

end
