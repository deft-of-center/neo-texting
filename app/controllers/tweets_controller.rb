class TweetsController < ApplicationController
  before_filter :signed_in_user

  def create
    current_user.tweets.create(params[:tweet])
    redirect_to current_user
  end
  def destroy
    tweet = current_user.tweets.find_by_id(params[:id])
    if tweet
      tweet.destroy
    end
    redirect_to current_user
  end
end
