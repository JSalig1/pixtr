class GroupMembershipActivity < Activity
  def email
    subject.member.email
  end

  def group
    subject.group
  end

  def group_name
    group.name
  end
end
