class MetricsController < ApplicationController
  self.resource = Metric
  self.serializer_class = MetricSerializer
  self.schema_class = MetricSchema
  before_action :set_roles, only: [:index, :show]
end
