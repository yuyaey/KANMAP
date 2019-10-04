class User < ApplicationRecord
  
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 30}
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  has_secure_password validations: false

  has_many :authorizations
  has_many :items, dependent: :destroy
  has_many :kanzumes, dependent: :destroy

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    email = auth[:info][:email]
    avatar = auth[:info][:image]
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.email = email
      user.avatar = avatar
    end
  end

end
