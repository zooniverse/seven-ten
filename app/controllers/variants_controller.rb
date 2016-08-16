class VariantsController < ApplicationController
  self.resource = Variant
  self.serializer_class = VariantSerializer
  self.schema_class = VariantSchema
end
