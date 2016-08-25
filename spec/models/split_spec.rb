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

  describe '.expired' do
    let!(:inactive){ create :split, ends_at: 1.day.ago }
    let!(:active){ create :split, state: 'active' }
    let!(:expired){ create :split, state: 'active', ends_at: 1.day.ago }
    subject{ Split.expired }
    it{ is_expected.to match_array [expired] }
  end

  describe '.for_project' do
    let(:project1){ create :project }
    let(:project2){ create :project }
    let!(:split1){ create :split, project: project1 }
    let!(:split2){ create :split, project: project2 }
    subject{ Split.for_project project1 }
    it{ is_expected.to match_array [split1] }
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

  pending 'transitioning state'
end
