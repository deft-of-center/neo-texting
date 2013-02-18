class TweetsController < ApplicationController
  before_filter :signed_in_user

  def create
    current_user.tweets.create(params[:tweet])
    redirect_to current_user
  end
  def destroy
    Tweet.find(params[:id]).destroy
    redirect_to current_user
  end
end
