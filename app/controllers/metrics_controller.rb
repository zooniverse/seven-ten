class MetricsController < ApplicationController
  self.resource = Metric
  self.serializer_class = MetricSerializer
  self.schema_class = MetricSchema
end
