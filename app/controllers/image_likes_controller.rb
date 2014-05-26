class ImageLikesController < ApplicationController
  def create
    @image = Image.find(params[:id])
    current_user.like @image
  end

  def destroy
    @image = Image.find(params[:id])
    current_user.unlike @image
  end
end