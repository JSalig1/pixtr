class GalleriesController < ApplicationController
  
  #before_filter :authorize  #this one line redirects to sign in b/c authorize is a method and this is run BEFORE any action
  before_action :authorize, except: [:show]  #same as above, better sounding mainly used for authorization, specific to clearance, Devise and others will be different than :authorize
  
  # except show allows public users to view galleries while not signed in.  just view.
  
  #after_action :authorize #executes after an action.  almost never used...
  #around_action :authorize #executes before AND after an action.  almost never used...
  
  
  
  def index #an action...  it renders a view from the views/galleries folder, create it if not present
   #nothing needed here, rails already has an index view... until now
   # @galleries = Gallery.all #same as in Sinatra
   
   @galleries = current_user.galleries
  end
  
  def show
    @gallery = Gallery.find(params[:id])  #params either comes from the forms (including URL) or the POST
    @images = @gallery.images.includes(gallery: [:user])
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    
    @gallery = current_user.galleries.new(gallery_params) #we get current_user as a helper from application controller via clearance which you can read on github
    # gallery = Gallery.create(gallery_params)
    if @gallery.save
      current_user.notify_followers(current_user, "GalleryActivity", @gallery)
      redirect_to @gallery #replaces below because rails will use polymorphic_path to find url and will automatically call .id on it at the same time
      # redirect_to gallery_path(gallery)   #rails via helpers will automatically call id on the object in the argument
      # redirect_to gallery_path(gallery.id)   #using helpers for urls
      # redirect_to "/galleries/#{gallery.id}"

    else
      render :new 
    end
  end
  
  def edit
    @gallery = current_user.galleries.find(params[:id]) 
  end
  
  def update
    @gallery = current_user.galleries.find(params[:id])
    if @gallery.update(gallery_params)
      redirect_to gallery_path(@gallery)
    else
      render :edit
    end
  end
  
  def destroy
    gallery = current_user.galleries.find(params[:id])   
    # gallery = Gallery.find(params[:id])
    gallery.destroy
    redirect_to galleries_path
  end
  
   
  private
  
  def gallery_params #whitelisting attributes to avoid forbidden attributes error! called Strong Params.
    params.require(:gallery).permit(:name)
  end
  
end
