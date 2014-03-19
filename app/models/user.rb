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
  
  def follow user # parenthesis left off, the irony of this comment will drive you crazy
    followed_users << user
  end
  
end
