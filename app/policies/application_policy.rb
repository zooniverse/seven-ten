require 'pundit'

class ApplicationPolicy
  attr_reader :user, :records

  def initialize(user, records)
    @user = user
    @records = Array.wrap records
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def admin?
    logged_in? && user.admin
  end

  def logged_in?
    !!user
  end

  def scope
    Pundit.policy_scope!(user, records.first.class)
  end

  def privileged_project_ids
    return [] unless logged_in?
    @privileged_project_ids ||= user.roles.select do |id, roles|
      (roles & %w(owner collaborator)).any?
    end.keys
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
