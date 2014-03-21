class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :galleries
  has_many :images, through: :galleries
  
  has_many :comments
  
  
  
  
  
  # Self-Referential Relationship, following_relationships join table
  
  has_many :followed_user_relationships, # alias for a table/model to differentiate from below
    foreign_key: :follower_id, # which column in said table
    class_name: "FollowingRelationship" # true name for said table
    
  has_many :followed_users, through: :followed_user_relationships
  
  # when both of these said ':following_relationships' the second one will override the first so it can't work.
  # so we need to specify the class name and differentiate the local name.
  
  has_many :follower_relationships, # alias for a table/model to differentiate from above
    foreign_key: :followed_user_id,  # which column in said table
    class_name: "FollowingRelationship" # true name for said table
    
  has_many :followers, through: :follower_relationships
  
  
  has_many :group_memberships, foreign_key: :member_id #otherwise rails assumes it will be the name of this class + "_id"
  has_many :groups, through: :group_memberships
  
  has_many :likes
  has_many :liked_images, 
    through: :likes,
    source: :image

    # class_name: "Image"
    # foriegn_key: ....?
    
  
  
  def following? user
    followed_user_ids.include? user.id
  end

  
  def follow user # parenthesis left off, the irony of this comment will drive you crazy
    followed_users << user
  end
  
  def unfollow user
    followed_users.destroy user
  end
  
  def join group
    groups << group
  end
  
  def leave group
    groups.destroy group
  end
  
  def member? group
    group_ids.include? group.id
  end
  
  def likes image
    liked_images << image
  end
  
  def like? image
    liked_images.include? image
  end
  
  def unlikes image
    liked_images.destroy image
  end
  
end
