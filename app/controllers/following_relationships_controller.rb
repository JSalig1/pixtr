class FollowingRelationshipsController < ApplicationController
  
  def create
    followed_user = User.find(params[:id])
    
    
    current_user.follow followed_user #abstraction the logic farther away into the model. fat models, skinny controllers. see user model for def.
    # current_user.followed_users << followed_user
    # current_user.following_relationships.create(followed_user_id: followed_user.id)
    
    redirect_to followed_user
  end

end