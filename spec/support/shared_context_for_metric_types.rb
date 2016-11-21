RSpec.shared_context 'a split with metric types' do
  let(:unknown_key){ create :split, key: 'foo.bar' }
  let(:landing_text){ create :split, key: 'landing.text' }
  let(:workflow_assignment){ create :split, key: 'workflow.assignment' }
  let(:workflow_advance){ create :split, key: 'workflow.advance' }
  let(:mini_course_visible){ create :split, key: 'mini-course.visible' }

  let(:default_metrics){ [] }
  let(:landing_text_metrics){ %w(classifier_visited classification_created) }
  let(:workflow_assignment_metrics){ %w(classifier_visited classification_created) }
  let(:workflow_advance_metrics){ %w(classification_created) }
  let(:mini_course_visible_metrics){ %w(classification_created) }
end
