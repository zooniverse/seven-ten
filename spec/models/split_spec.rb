RSpec.describe Split, type: :model do
  context 'validating' do
    it 'should require a name' do
      without_name = build :split, name: nil
      expect(without_name).to fail_validation name: "can't be blank"
    end

    it 'should require a key' do
      without_key = build :split, key: nil
      expect(without_key).to fail_validation key: "can't be blank"
    end

    context 'when limiting active keys' do
      let(:project){ create :project }
      let!(:split){ create :split, project: project, key: 'test', state: 'active' }

      it 'should prevent duplicates' do
        duplicate = build :split, project: project, key: 'test', state: 'active'
        expect(duplicate).to fail_validation key: "Only one split can be active on 'test' at a time"
      end

      it 'should allow inactive duplicates' do
        inactive = build :split, project: project, key: 'test', state: 'inactive'
        expect(inactive).to_not fail_validation
      end

      it 'should scope to the project' do
        different = build :split, key: 'test', state: 'active'
        expect(different).to_not fail_validation
      end
    end

    it 'should require a project' do
      without_project = build :split, project: nil, name: 'split'
      expect(without_project).to fail_validation project: 'must exist'
    end

    it 'should require a valid state' do
      invalid_state = build :split, state: 'invalid'
      expect(invalid_state).to fail_validation state: 'is not a valid state'
    end
  end

  describe '.pending' do
    let!(:inactive){ create :split, starts_at: 1.day.from_now }
    let!(:active){ create :split, state: 'active' }
    let!(:pending){ create :split, state: 'inactive', starts_at: 1.day.ago }
    subject{ Split.pending }
    it{ is_expected.to match_array [pending] }
  end

  describe '.expired' do
    let!(:inactive){ create :split, ends_at: 1.day.ago }
    let!(:active){ create :split, state: 'active' }
    let!(:expired){ create :split, state: 'active', ends_at: 1.day.ago }
    subject{ Split.expired }
    it{ is_expected.to match_array [expired] }
  end

  describe '#variants.weighted_sample' do
    let(:split){ create :split }

    context 'with unweighted variants' do
      let!(:variants){ create_list :variant, 2, split: split }
      it 'should sample randomly' do
        expect(split.variants).to receive :sample
        split.variants.weighted_sample
      end
    end

    context 'with weighted variants' do
      let!(:lower){ create :variant, split: split, weight: 1 }
      let!(:higher){ create :variant, split: split, weight: 99 }

      it 'should not sample randomly' do
        expect(split.variants).to_not receive :sample
        split.variants.weighted_sample
      end

      it 'should weight the results' do
        counts = Hash.new 0
        100.times.collect{ counts[split.variants.weighted_sample.id] += 1 }
        expect(counts[higher.id]).to be > counts[lower.id]
      end
    end
  end

  describe '#assign_user' do
    let(:split){ create :split, state: 'active' }
    let(:user){ create :user }
    subject{ split.assign_user user }

    context 'when sampling' do
      let!(:variant){ create :variant, split: split }

      it 'should use weighted sampling' do
        expect(split.variants).to receive(:weighted_sample).and_call_original
        split.assign_user user
      end
    end

    context 'when the user is already assigned' do
      let!(:assigned){ create :split_user_variant, user: user, split: split }
      it{ is_expected.to eql assigned }
    end

    context 'when the user is not assigned' do
      let!(:variant){ create :variant, split: split }
      its(:variant){ is_expected.to eql variant }
    end

    context 'when the assignment is contentious' do
      let(:model_double){ double first_or_create: nil }
      let(:query_double){ double where: nil }
      let!(:variants){ create_list :variant, 2, split: split }
      let!(:assigned){ create :split_user_variant, user: user, split: split }
      let(:duplicate){ build :split_user_variant, user: user, split: split }

      def expect_assignment(suv)
        expect(model_double).to receive(:where).once.ordered
          .and_return query_double
        expect(query_double).to receive(:first_or_create).once.ordered
          .and_return(suv).and_yield suv
      end

      before(:each) do
        expect(split).to receive(:split_user_variants).twice.and_return model_double
        expect_assignment duplicate
        expect_assignment assigned
      end

      it{ is_expected.to eql assigned }
    end
  end

  describe '#active?' do
    context 'when active' do
      subject{ create(:split, state: 'active').active? }
      it{ is_expected.to be true }
    end

    context 'when inactive' do
      subject{ create(:split, state: 'inactive').active? }
      it{ is_expected.to be false }
    end
  end

  describe '#set_ends_at' do
    subject{ create :split }
    its(:ends_at){ is_expected.to be_within(1.second).of 2.weeks.from_now }

    context 'with a specified date' do
      subject{ create :split, ends_at: 1.day.from_now }
      its(:ends_at){ is_expected.to be_within(1.second).of 1.day.from_now }
    end
  end

  describe '#set_metric_types' do
    include_context 'a split with metric types' do
      context 'for an unknown key' do
        subject{ unknown_key.metric_types }
        it{ is_expected.to match_array default_metrics }
      end

      context 'for landing text' do
        subject{ landing_text.metric_types }
        it{ is_expected.to match_array landing_text_metrics }
      end

      context 'for workflow assignment message' do
        subject{ workflow_assignment.metric_types }
        it{ is_expected.to match_array workflow_assignment_metrics }
      end

      context 'for workflow advance message' do
        subject{ workflow_advance.metric_types }
        it{ is_expected.to match_array workflow_advance_metrics }
      end

      context 'for landing text' do
        subject{ mini_course_visible.metric_types }
        it{ is_expected.to match_array mini_course_visible_metrics }
      end

      context 'for first to classify subject' do
        subject{ subject_first_to_classify.metric_types }
        it{ is_expected.to match_array subject_first_to_classify_metrics }
      end
    end
  end
end
