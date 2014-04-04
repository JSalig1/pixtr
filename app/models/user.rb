class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries
  
  has_many :comments, dependent: :destroy
  
  # Self-Referential Relationship, following_relationships join table
  
  has_many :followed_user_relationships, # alias for a table/model to differentiate from below
    foreign_key: :follower_id, # which column in said table
    class_name: "FollowingRelationship", # true name for said table
    dependent: :destroy
    
  has_many :followed_users, through: :followed_user_relationships
  
  # when both of these said ':following_relationships' the second one will override the first so it can't work.
  # so we need to specify the class name and differentiate the local name.
  
  has_many :follower_relationships, # alias for a table/model to differentiate from above
    foreign_key: :followed_user_id,  # which column in said table
    class_name: "FollowingRelationship", # true name for said table
    dependent: :destroy
    
  has_many :followers, through: :follower_relationships
  
  
  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy #otherwise rails assumes it will be the name of this class + "_id"
  has_many :groups, through: :group_memberships
  
  has_many :likes, dependent: :destroy
  # has_many :liked_images, 
  #   through: :likes,
  #   source: :likable,
  #   source_type: "Image"

    # class_name: "Image"
    # foriegn_key: ....?
    
  has_many :activities
  
  
  def upgraded?
    customer_id.present?
  end  
  
  
  def following? user
    followed_user_ids.include? user.id
  end

  
  def follow user # parenthesis left off, the irony of this comment will drive you crazy
    # followed_users << user
    
    following_relationship = followed_user_relationships.create(followed_user: user)
    # notify_followers.(following_relationship, 'FollowActivity')
    
    # followers.each do |follower|
    #   follower.activities.create(
    #   subject: following_relationship,
    #   type: 'FollowActivity'
    #   )
    # end
    
  end
  
  def unfollow user
    followed_users.destroy user
  end
  
  def join group
    # groups << group
    

    group_membership = group_memberships.create(group: group)
    notify_followers(group_membership, "GroupMembershipActivity", group)
    # followers.each do |follower|
    #   follower.activities.create(
    #   subject: group_membership,
    #   type: 'GroupMembershipActivity'
    #   )
    # end
    
  end
  
  def leave group
    groups.destroy group
  end
  
  def member? group
    group_ids.include? group.id
  end
  
  def like target
    # liked_images << image
    like = likes.create(likable: target)
    notify_followers(like, "LikeActivity", target)
    # followers.each do |follower|
    #   follower.activities.create(
    #   subject: like,
    #   type: 'LikeActivity'
    #   )
    # end
    
  end
  
  def like? target
    likes.exists?(likable: target) # replaces two lines below, active record method, checks database, more effiecient than below
    # like = likes.find_by(likable: target)
    # likes.include? like
  end
  
  def unlike target
    like = likes.find_by(likable: target)
    like.destroy
  end
  
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
  handle_asynchronously :notify_followers
  
end
