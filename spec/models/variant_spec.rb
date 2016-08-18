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
end
