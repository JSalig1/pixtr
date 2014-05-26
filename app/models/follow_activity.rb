class FollowActivity < Activity
  def email
    subject.follower.email
  end

  def followed_user
    subject.followed_user
  end

  def followed_user_name
    followed_user.email
  end
end
