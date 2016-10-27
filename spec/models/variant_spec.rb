RSpec.describe Variant, type: :model do
  context 'validating' do
    it 'should require a split' do
      without_split = build :variant, split: nil
      expect(without_split).to fail_validation split: 'must exist'
    end

    it 'should require a name' do
      without_name = build :variant, name: nil
      expect(without_name).to fail_validation name: "can't be blank"
    end

    it 'should require a value' do
      without_value = build :variant, value: nil
      expect(without_value).to fail_validation value: "can't be blank"
    end
  end

  describe '#set_project' do
    let(:split){ create :split }
    subject{ build :variant, split: split }

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
        subject.update_attributes name: 'test'
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
