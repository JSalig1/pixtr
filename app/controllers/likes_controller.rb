class LikesController < ApplicationController
  
  def create
    image = Image.find(params[:id])
    current_user.likes image
    redirect_to image
  end
  
  def destroy
    image = Image.find(params[:id])
    current_user.unlikes image
    redirect_to image
  end
  
end