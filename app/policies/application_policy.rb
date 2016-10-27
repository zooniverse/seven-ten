require 'pundit'

class ApplicationPolicy
  include UserRoles

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

  class Scope
    include UserRoles
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
