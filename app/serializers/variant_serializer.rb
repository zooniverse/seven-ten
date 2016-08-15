class VariantSerializer < ApplicationSerializer
  attributes :name, :key, :value, :split_id
  filterable_by :key, :split_id

  link(:self){ variant_path object }
  link(:split){ split_path object.split }
end
