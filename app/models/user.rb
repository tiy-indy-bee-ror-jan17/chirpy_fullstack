class User < ApplicationRecord
  has_many :chirps
  has_secure_password

  mount_uploader :profile_photo, UserAvatarUploader

  acts_as_follower
  acts_as_followable

  # default_scope { where(active: true) }

  # User.active
  # scope :active, -> { where(active: true) }

  validates :username, :avatar, presence: true
  validates :username, uniqueness: true
  # validates_uniqueness_of :username

  # def avatar
  #   attributes["avatar"].blank? ? "https://robohash.org/#{username}.png" : attributes["avatar"]
  # end

  def to_s
    username
  end

  def persona(version = :standard)
    if profile_photo?
      profile_photo.versions[version].url
    elsif !avatar.blank?
      avatar
    else
      "https://pbs.twimg.com/profile_images/810194608093282305/dj7DmKQ9.jpg"
    end
  end

end
