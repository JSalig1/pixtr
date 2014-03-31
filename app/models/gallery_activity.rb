class GalleryActivity < Activity
  
  def owner
    actor.email
  end
  
  def gallery_name
    subject.name
  end
  
  def gallery
    target
  end
  

end