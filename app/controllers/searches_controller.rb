class SearchesController < ApplicationController
  
  
  def index
    image_searcher = ImageSearcher.new(params[:query])
    @results = image_searcher.search
    
    #.includes(gallery: [:user])
    
  end
  
  
end
