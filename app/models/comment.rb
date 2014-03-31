class Comment < ActiveRecord::Base
  
  # belongs_to :comment_table, polymorphic: true
  
  belongs_to :user
  belongs_to :image
  
  
  
  has_many :activities, as: :subject, dependent: :destroy
  
  validates :body, presence: true  #data validation, comes from ActiveRecord::Base!
  validates :user, presence: true
  
  #scope :recent, -> { order(created_at: :desc) }  #same as below, alternate syntax... just be able to recognize that.
  
  def self.recent   #class method, calling on a class not on an instance
    order(created_at: :desc)
  end
  
end
