class VariantPolicy < ApplicationPolicy
  delegate :writable?, to: :split_policy

  def create?
    writable?
  end

  def update?
    writable?
  end

  def destroy?
    writable?
  end

  def split_policy
    SplitPolicy.new user, splits
  end

  def splits
    records.compact.collect(&:split).uniq.compact
  end
end
