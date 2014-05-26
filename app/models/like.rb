class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user
  has_many :activities, as: :subject, dependent: :destroy
  validates :likable, presence: true
end
