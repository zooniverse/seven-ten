class SplitSerializer < ApplicationSerializer
  attributes :name, :key, :state, :project_id, :ends_at, :created_at, :updated_at
  filterable_by :project_id, :key, :state

  link(:self){ split_path object }
  link(:variants){ variants_path filter: { split_id: object.id } }
end
