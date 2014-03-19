class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :galleries
  has_many :images, through: :galleries
  has_many :comments
  
  has_many :group_memberships, foreign_key: :member_id #otherwise rails assumes it will be the name of this class + "_id"
  has_many :groups, through: :group_memberships
  
end
