RSpec.describe Metric, type: :model do
  context 'validating' do
    it 'should require a split user variant' do
      without_suv = build :metric, split_user_variant: nil
      expect(without_suv).to fail_validation split_user_variant: 'must exist'
    end

    it 'should require a key' do
      without_key = build :metric, key: nil
      expect(without_key).to fail_validation key: "can't be blank"
    end
  end

  describe '#set_project' do
    let(:suv){ create :split_user_variant }
    subject{ build :metric, split_user_variant: suv }

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
        subject.update_attributes key: 'test'
      end
    end

    it 'should set the project' do
      expect{
        subject.set_project
      }.to change{
        subject.project
      }.to suv.project
    end
  end
end
