class SplitsController < ApplicationController
  self.resource = Split
  self.serializer_class = SplitSerializer
  self.schema_class = SplitSchema
  before_action :set_roles
end
