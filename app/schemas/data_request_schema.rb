class DataRequestSchema < ApplicationSchema
  def create
    root do |root_object|
      id :split_id, required: true
      additional_properties false
    end
  end
end
