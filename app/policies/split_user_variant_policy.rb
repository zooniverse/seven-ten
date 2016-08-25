class SplitUserVariantPolicy < ApplicationPolicy
  def index?
    logged_in?
  end

  def show?
    owner?
  end

  def owner?
    records.compact.all?{ |record| user == record.user }
  end

  class Scope < Scope
    def resolve
      scope.where user: user
    end
  end
end
