class SplitUserVariantSerializer < ApplicationSerializer
  belongs_to :split
  belongs_to :variant
  filterable_by :split_id, :'projects.slug'
  include_by_default :split, :variant

  link(:self){ split_user_variant_path object }
  link(:split){ split_path object.split }
  link(:variant){ variant_path object.variant }
end
