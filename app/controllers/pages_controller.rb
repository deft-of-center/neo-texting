class PagesController < ApplicationController

  def home
    if signed_in?
      @tweet = current_user.tweets.build
      @tweets = current_user.tweets_by_followed_users
    else
      @tweets = Tweet.recent_tweets
    end
  end

  def show
    render :action => params[:page]
  end

end
