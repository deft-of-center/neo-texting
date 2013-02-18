class Tweet < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  default_scope order: 'tweets.created_at DESC'

  validates :content, length: { maximum: 140 }

  def self.recent_tweets
    Tweet.limit(30)
  end
  
end
