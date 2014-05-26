class LikeActivity < Activity
  def email
    actor.email
  end

  def likable
    target
  end

  def likable_name
    likable.name
  end
end
