class GroupMembership < ActiveRecord::Base
  belongs_to :member, class_name: "User"  #for readability... could have used users all through but we fix that here so it can be more readable everywhere else.
  belongs_to :group
end