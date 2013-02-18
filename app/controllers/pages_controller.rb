class PagesController < ApplicationController
  before_filter :signed_in_user
  before_filter :make_tweet_obj


  def home
    if signed_in?
      @tweets = current_user.tweets_by_followed_users
    else
      @tweets = Tweet.recent_tweets
    end
  end

  def show
    render :action => params[:page]
  end

end
