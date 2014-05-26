class GalleriesController < ApplicationController
  before_action :authorize, except: [:show]

  def index
   @galleries = current_user.galleries
  end

  def show
    @gallery = find_gallery
    @images = @gallery.images.includes(gallery: [:user])
  end

  def new
    @gallery = Gallery.new
  end

  def create

    @gallery = current_user.galleries.new(gallery_params)
    if @gallery.save
      current_user.notify_followers(current_user, "GalleryActivity", @gallery)
      redirect_to @gallery
    else
      render :new
    end
  end

  def edit
    @gallery = find_gallery_owned_by_user
  end

  def update
    @gallery = find_gallery_owned_by_user
    if @gallery.update(gallery_params)
      redirect_to gallery_path(@gallery)
    else
      render :edit
    end
  end

  def destroy
    gallery = find_gallery_owned_by_user
    gallery.destroy
    redirect_to galleries_path
  end

  private

  def find_gallery
    Gallery.find(params[:id])
  end

  def find_gallery_owned_by_user
    current_user.galleries.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name)
  end
end
