class ImageSearcher
  
  def initialize(query)
    @query = query
  end
  
  def search
    if @query
      Image.includes(gallery: [:user]).find(:all, :conditions => ['name ILIKE ?', "%#{@query}%"])
      Image.includes(gallery: [:user]).find(:all, :conditions => ['description ILIKE ?', "%#{@query}%"])
    else
      Image.includes(gallery: [:user]).find(:all)
    end
  end
  
end