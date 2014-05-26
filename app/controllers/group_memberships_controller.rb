class GroupMembershipsController < ApplicationController
  
  def create
    @group = Group.find(params[:id])
    group_membership = current_user.join @group
    notify_followers(group_membership, @group)
    render :change
  end
  
  def destroy
    @group = Group.find(params[:id])
    current_user.leave @group
    render :change
  end
  
end