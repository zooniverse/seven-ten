class SplitsController < ApplicationController
  self.resource = Split
  self.serializer_class = SplitSerializer
  self.schema_class = SplitSchema
end
