class Gallery < ActiveRecord::Base
  has_many :images, dependent: :destroy
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  
  
  
  has_many :activities, as: :subject, dependent: :destroy
  
  validates :name, presence: true
  validates :user, presence: true
  
end
