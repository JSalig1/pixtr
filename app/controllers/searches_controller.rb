class SearchesController < ApplicationController
  
  
  def index
    @results = Image.search(params[:query])
    
  end
  
  
end
