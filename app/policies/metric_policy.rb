class MetricPolicy < ApplicationPolicy
  delegate :admin_or_project_owner?, to: :project_policy

  def index?
    logged_in?
  end

  def show?
    admin_or_project_owner?
  end

  def create?
    logged_in? && split_users.all?{ |u| u == user }
  end

  def project_policy
    ProjectPolicy.new user, projects
  end

  def projects
    records.compact.collect(&:project).uniq.compact
  end

  def split_users
    records.compact.collect(&:user).uniq.compact
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
