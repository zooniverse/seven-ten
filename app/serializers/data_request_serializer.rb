class DataRequestSerializer < ApplicationSerializer
  belongs_to :split
  attributes :split_id, :state, :url, :created_at, :updated_at
  filterable_by :split_id, :'projects.slug'
  include_by_default :split

  link(:self){ data_request_path object }
  link(:split){ split_path object.split }
end
