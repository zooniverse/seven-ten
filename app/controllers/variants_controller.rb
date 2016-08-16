class VariantsController < ApplicationController
  self.resource = Variant
  self.serializer_class = VariantSerializer
end
