module UsersHelper

  def make_tweet_obj
    @tweet = current_user.tweets.build if signed_in?
  end

end
