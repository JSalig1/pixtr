class ImagesController < ApplicationController
  
  def show
    @image = Image.find(params[:id])
    
    @comment = Comment.new
    
    @comments = @image.comments.recent      #.where("body ILIKE ? '%wombat%'")
    
  end
  
  def new
    @gallery = current_user.galleries.find(params[:gallery_id])
    # @gallery = Gallery.find(params[:gallery_id])
    
    @image = Image.new
  end
  
  def create
    
    
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = @gallery.images.new(image_params)
    if @image.save
      redirect_to @gallery #replaces below because rails will use polymorphic_path to find url and will automatically call .id on it at the same time
      # redirect_to gallery_path(gallery)   #rails via helpers will automatically call id on the object in the argument
      # redirect_to gallery_path(gallery.id)   #using helpers for urls
      # redirect_to "/galleries/#{gallery.id}"

    else
      render :new  #use this instead of redirect b/c with redirect the data goes away, render keeps it. we need to change variables to instance variables to pass them in though.
    end

  end
  
  def edit
    @image = current_user.images.find(params[:id])
    # @image = Image.find(params[:id])
    
  end
  
  def update
    
    @image = current_user.images.find(params[:id])
    # image = Image.find(params[:id])
    if @image.update(image_params)
      redirect_to @image
    else
      render :edit
    end
  end
  
  def destroy
    image = current_user.images.find(params[:id])
    # image = Image.find(params[:id])
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