class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true
  belongs_to :actor, class_name: "User"
  belongs_to :target, polymorphic: true

  def self.new_activity(subject, target, actor)
    Activity.create(
        subject: subject,
        type: type(subject),
        actor: actor,
        target: target
        )
  end

  private

  def self.type(subject)
    "#{subject.class}Activity"
  end
end
