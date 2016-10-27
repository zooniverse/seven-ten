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

  class Scope < Scope
    def resolve
      if user && user.admin
        scope.all
      elsif user
        scope.joins(:project).where project_id: privileged_project_ids
      else
        scope.none
      end
    end
  end
end
