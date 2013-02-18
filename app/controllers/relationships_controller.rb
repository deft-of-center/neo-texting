class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    followed_user = User.find(params[:relationship][:followed_id])
    current_user.follow(followed_user)
    redirect_to user_path(followed_user)
  end

  def destroy
    followed_user = Relationship.find(params[:id]).followed
    current_user.unfollow(followed_user)
    redirect_to followed_user
  end
end
