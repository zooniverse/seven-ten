class VariantSchema < ApplicationSchema
  def create
    changes required: true
  end

  def update
    changes
  end

  def changes(required = { })
    root do |root_object|
      id :split_id, **required
      string :name, **required

      object :value, **required do |value|
        value.additional_properties true
      end

      additional_properties false
    end
  end
end
