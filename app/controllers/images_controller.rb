class ImagesController < ApplicationController
  
  def show
    @image = Image.find(params[:id])
  end
  
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
  
  def edit
    @image = Image.find(params[:id])
  end
  
  def update
    image = Image.find(params[:id])
    image.update(image_params)
    redirect_to image
  end
  
  def destroy

    image = Image.find(params[:id])
    image.destroy
    redirect_to image.gallery  #requires "belongs_to :gallery" in the Image Model
    # redirect_to gallery_path(image.gallery_id)
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