class SplitUserVariantsController < ApplicationController
  self.resource = SplitUserVariant
  self.serializer_class = SplitUserVariantSerializer
  before_action :ensure_assigned, if: :assignable?

  def resource_scope
    SplitUserVariant.joins(:split, :project).where splits: { state: 'active' }
  end

  def ensure_assigned
    active_splits.each do |split|
      split.assign_user current_user
    end
  end

  protected

  def assignable?
    current_user && project_slug
  end

  def project_slug
    filter_params['projects.slug']
  end

  def active_splits
    project = Project.find_by_slug! project_slug
    project.splits.active
  end
end
