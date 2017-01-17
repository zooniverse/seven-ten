module MetricTypes
  extend ActiveSupport::Concern

  METRIC_TYPES = {
    'landing.text' => [
      'classifier_visited',
      'classification_created'
    ],
    'workflow.assignment' => [
      'classifier_visited',
      'classification_created'
    ],
    'workflow.advance' => [
      'classification_created'
    ],
    'mini-course.visible' => [
      'classification_created'
    ],
    'subject.first-to-classify' => [
      'classification_created'
     ]
  }

  included do
    before_save :set_metric_types
  end

  def metrics_for(key)
    METRIC_TYPES[key]
  end

  def set_metric_types
    self.metric_types = metrics_for(key) || []
  end
end
