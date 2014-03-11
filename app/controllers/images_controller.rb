class ImagesController < ApplicationController
  
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @image = Image.new
  end
  
  def create
    gallery = Gallery.find(params[:gallery_id])    
    gallery.images.create(image_params)
    
    redirect_to gallery #replaces below because rails will use polymorphic_path to find url and will automatically call .id on it at the same time
    # redirect_to gallery_path(gallery)   #rails via helpers will automatically call id on the object in the argument
    # redirect_to gallery_path(gallery.id)   #using helpers for urls
    # redirect_to "/galleries/#{gallery.id}"
  end
  
  
  
  private
  
  def image_params #whitelisting attributes to avoid forbidden attributes error! called Strong Params.
    params.require(:image).permit(
      :name, 
      :description, 
      :url
    )
  end
  
end