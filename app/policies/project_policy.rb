class ProjectPolicy < ApplicationPolicy
  def create?
    writable?
  end

  # TO-DO: also check user/project role permissions
  def writable?
    admin?
  end
end
