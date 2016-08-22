class VariantPolicy < ApplicationPolicy
  delegate :admin_or_project_owner?, to: :split_policy

  def create?
    admin_or_project_owner?
  end

  def update?
    admin_or_project_owner?
  end

  def destroy?
    admin_or_project_owner?
  end

  def split_policy
    SplitPolicy.new user, splits
  end

  def splits
    records.compact.collect(&:split).uniq.compact
  end
end
