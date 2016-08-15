RSpec.describe Split, type: :model do
  context 'validating' do
    it 'should require a name' do
      without_name = build :split, name: nil
      expect(without_name).to fail_validation name: "can't be blank"
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

  describe '.expired' do
    let!(:inactive){ create :split, ends_at: 1.day.ago }
    let!(:active){ create :split, state: 'active' }
    let!(:expired){ create :split, state: 'active', ends_at: 1.day.ago }
    subject{ Split.expired }
    it{ is_expected.to match_array [expired] }
  end

  describe '#set_ends_at' do
    subject{ create :split }
    its(:ends_at){ is_expected.to be_within(1.second).of 2.weeks.from_now }

    context 'with a specified date' do
      subject{ create :split, ends_at: 1.day.from_now }
      its(:ends_at){ is_expected.to be_within(1.second).of 1.day.from_now }
    end
  end

  pending 'transitioning state'
end
