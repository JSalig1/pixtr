class Notification
  
  
  
  
  def notify_followers(subject, type, target)
    if subject.persisted?
      followers.each do |follower|
        new_activity = follower.activities.create(
        subject: subject,
        type: type,
        actor: self,
        target: target
        )
        UserMailer.notification_email(follower, new_activity).deliver
      end
    end
  end
    
  

  
end
