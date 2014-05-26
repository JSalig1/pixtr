class FollowerNotifier
  def initialize(user)
    @user = user
  end

  def notify(subject, target)
    if subject.persisted?
      user.followers.each do |follower|
        new_activity = follower.activities.create(
        subject: subject,
        type: type(subject),
        actor: user,
        target: target
        )
        UserMailer.notification_email(follower, new_activity).deliver
      end
    end
  end

  private

  attr_reader :user

  def type(subject)
    "#{subject.class}Activity"
  end
end
