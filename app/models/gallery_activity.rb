class GalleryActivity < Activity
  
  def owner
    subject.user.email
  end
  
  def gallery_name
    subject.name
  end
  
  def gallery
    subject
  end
  

end