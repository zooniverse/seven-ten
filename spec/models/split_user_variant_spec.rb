RSpec.describe SplitUserVariant, type: :model do
  context 'validating' do
    it 'should require a split' do
      without_split = build :split_user_variant, split: nil
      expect(without_split).to fail_validation split: 'must exist'
    end

    it 'should require a user' do
      without_user = build :split_user_variant, user: nil
      expect(without_user).to fail_validation user: 'must exist'
    end

    it 'should require a variant' do
      without_variant = build :split_user_variant, variant: nil
      expect(without_variant).to fail_validation variant: 'must exist'
    end
  end

  describe '#set_project' do
    let(:split){ create :split }
    subject{ build :split_user_variant, split: split }

    context 'when creating' do
      it 'should be called before validation' do
        expect(subject).to receive :set_project
        subject.save
      end
    end

    context 'when updating' do
      it 'should not be called' do
        subject.save
        expect(subject).to_not receive :set_project
        subject.update_attributes user_id: 123
      end
    end

    it 'should set the project' do
      expect{
        subject.set_project
      }.to change{
        subject.project
      }.to split.project
    end
  end
end
