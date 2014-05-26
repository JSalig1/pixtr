class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries
  has_many :comments, dependent: :destroy
  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships
  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :likes, dependent: :destroy
  has_many :activities

  def upgraded?
    customer_id.present?
  end

  def following? user
    followed_user_ids.include? user.id
  end

  def follow user
    following_relationship = followed_user_relationships.create(followed_user: user)
  end

  def unfollow user
    followed_users.destroy user
  end

  def join group
    group_membership = group_memberships.create(group: group)
  end

  def leave group
    groups.destroy group
  end

  def member? group
    group_ids.include? group.id
  end

  def like target
    like = likes.create(likable: target)
    notify_followers(like, "LikeActivity", target)
  end

  def like? target
    likes.exists?(likable: target)
  end

  def unlike target
    like = likes.find_by(likable: target)
    like.destroy
  end
end
