class DataRequestPolicy < ApplicationPolicy
  delegate :admin_or_project_owner?, to: :project_policy

  def index?
    logged_in?
  end

  def show?
    admin_or_project_owner?
  end

  def create?
    admin_or_project_owner?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def project_policy
    ProjectPolicy.new user, projects
  end

  def projects
    records.compact.collect(&:project).uniq.compact
  end

  class Scope < Scope
    def resolve
      privileged_policy_scope
    end
  end
end
