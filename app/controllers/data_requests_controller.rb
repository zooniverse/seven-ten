class DataRequestsController < ApplicationController
  self.resource = DataRequest
  self.serializer_class = DataRequestSerializer
  self.schema_class = DataRequestSchema
end
