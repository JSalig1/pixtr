class FollowingRelationshipsController < ApplicationController
  
  def index
    @followed_users = current_user.followed_users
    @followers = current_user.followers
  end
  
  def create
    followed_user = User.find(params[:id])
    
    
    current_user.follow followed_user #abstraction the logic farther away into the model. fat models, skinny controllers. see user model for def.
    # current_user.followed_users << followed_user
    # current_user.following_relationships.create(followed_user_id: followed_user.id)
    
    redirect_to followed_user
  end
  
  def destroy
    unfollowed_user = User.find(params[:id])  
    current_user.unfollow unfollowed_user    
    redirect_to unfollowed_user
  end

end