class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :password, :password_confirmation, :username
  has_secure_password
  has_many :tweets, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :full_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { within: 6..40 }, on: :create
  validates :password, length: { within: 6..40 }, on: :update, unless: lambda{ |user| user.password.blank? }
  validates :password_confirmation, presence: true, on: :create

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id) unless other_user.nil?
  end
  def follow(followed_user)
    relationships.create(followed_id: followed_user.id) unless following?(followed_user)
  end

  def unfollow(followed_user)
    relationships.find_by_followed_id(followed_user.id).destroy
  end

  def tweets_by_followed_users
    followed_ids = followed_users.map { |f| f.id } << id
    Tweet.where( "user_id IN (#{followed_ids.join(',')})")
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
