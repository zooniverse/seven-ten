class MetricSerializer < ApplicationSerializer
  attributes :key, :value, :split_user_variant_id
  filterable_by :key, :split_user_variant_id

  link(:self){ metric_path object }
end
