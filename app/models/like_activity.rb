class LikeActivity < Activity
  
  def email
    subject.user.email
  end
  
  def likable
    subject.likable
  end
  
  def likable_name
    likable.name
  end
  
end