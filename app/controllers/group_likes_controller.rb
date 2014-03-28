class GroupLikesController < ApplicationController
  
  def create
    group = Group.find(params[:id])
    current_user.like group

  end
  
  def destroy
    group = Group.find(params[:id])
    current_user.unlike group

  end
  
end