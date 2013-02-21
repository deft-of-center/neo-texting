class PagesController < ApplicationController

  def home
    if signed_in?
      params[:origin] ||= "following"
      @tweet = current_user.tweets.build
      @tweets = params[:origin] == 'following' ? current_user.tweets_by_followed_users : Tweet.recent_tweets
      @origin = params[:origin]
    else
      @tweets = Tweet.recent_tweets
    end
  end

  def show
    @tweet = current_user.tweets.build
    render :action => params[:page]
  end

end
