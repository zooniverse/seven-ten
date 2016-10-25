class SplitSerializer < ApplicationSerializer
  attributes :name, :key, :state, :project_id, :metric_types, :ends_at, :created_at, :updated_at
  filterable_by :project_id, :key, :state

  link(:self){ split_path object }
  link(:variants){ variants_path filter: { split_id: object.id } }
  link(:data_requests){ data_requests_path filter: { split_id: object.id } }
end
