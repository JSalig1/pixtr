class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user
  
  has_many :activities, as: :subject, dependent: :destroy
  
  # validates :likable_id,
  #   uniqueness: { scope: :user_id }
  
  validates :likable, presence: true
  # validates :user, presence: true,
  #   uniqueness: { scope: :likable }

end

