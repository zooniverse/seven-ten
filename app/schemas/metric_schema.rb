class MetricSchema < ApplicationSchema
  def create
    root do |root_object|
      id :split_user_variant_id, required: true
      string :key, required: true
      object :value, required: true do |value|
        value.additional_properties true
      end
      additional_properties false
    end
  end
end
