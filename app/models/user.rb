class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :password, :password_confirmation, :username
  has_secure_password
  has_many :tweets, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :full_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
