class SplitPolicy < ApplicationPolicy
  delegate :admin_or_project_owner?, to: :project_policy

  def create?
    admin_or_project_owner?
  end

  def update?
    admin_or_project_owner?
  end

  def destroy?
    admin_or_project_owner?
  end

  def project_policy
    ProjectPolicy.new user, projects
  end

  def projects
    records.compact.collect(&:project).uniq.compact
  end
end
