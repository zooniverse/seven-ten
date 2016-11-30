class VariantsController < ApplicationController
  self.resource = Variant
  self.serializer_class = VariantSerializer
  self.schema_class = VariantSchema
  before_action :set_roles
end
