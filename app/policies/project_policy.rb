class ProjectPolicy < ApplicationPolicy
  def create?
    admin_or_project_owner?
  end

  # TO-DO: also check user/project role permissions
  def admin_or_project_owner?
    admin?
  end
end
