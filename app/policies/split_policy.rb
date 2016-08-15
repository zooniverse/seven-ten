class SplitPolicy < ApplicationPolicy
  delegate :writable?, to: :project_policy

  def create?
    writable?
  end

  def update?
    writable?
  end

  def destroy?
    writable?
  end

  def project_policy
    ProjectPolicy.new user, projects
  end

  def projects
    records.compact.collect(&:project).uniq.compact
  end
end
