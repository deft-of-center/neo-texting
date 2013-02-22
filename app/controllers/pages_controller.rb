class PagesController < ApplicationController

  def home
    @origin = params[:origin]
    @origin ||= "following"
    if signed_in?
      if @origin == "following"
        @tweets = current_user.tweets_by_followed_users
      else
        @tweets = Tweet.recent_tweets
      end
    else
      @tweets = Tweet.recent_tweets
    end
  end

  def show
    render :action => params[:page]
  end

end
