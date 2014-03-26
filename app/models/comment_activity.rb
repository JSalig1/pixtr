class CommentActivity < Activity
  
  def email
    subject.user.email
  end
  
  def commented_image
    subject.image.name
  end
  
  def image
    subject.image
  end
  

end