class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }

  has_many :items, dependent: :destroy
  has_many :kanzumes, dependent: :destroy

end
