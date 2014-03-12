class GalleriesController < ApplicationController
  
  def index #an action...  it renders a view from the views/galleries folder, create it if not present
   #nothing needed here, rails already has an index view... until now
   @galleries = Gallery.all #same as in Sinatra
  end
  
  def show
    @gallery = Gallery.find(params[:id])  #params either comes from the forms (including URL) or the POST
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    gallery = Gallery.create(gallery_params)
    redirect_to gallery_path(gallery)
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
  end
  
  def update
    gallery = Gallery.find(params[:id])
    gallery.update(gallery_params)
    redirect_to gallery_path(gallery)  
  end
  
  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    redirect_to root_path
  end
  
   
  private
  
  def gallery_params #whitelisting attributes to avoid forbidden attributes error! called Strong Params.
    params.require(:gallery).permit(:name)
  end
  
end