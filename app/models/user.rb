class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :password, :password_confirmation, :username
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :full_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
