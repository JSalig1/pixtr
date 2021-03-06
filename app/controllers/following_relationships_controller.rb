class FollowingRelationshipsController < ApplicationController
  def index
    @followed_users = current_user.followed_users
    @followers = current_user.followers
  end

  def create
    followed_user = User.find(params[:id])
    current_user.follow followed_user
    redirect_to followed_user
  end

  def destroy
    unfollowed_user = User.find(params[:id])
    current_user.unfollow unfollowed_user
    redirect_to unfollowed_user
  end
end