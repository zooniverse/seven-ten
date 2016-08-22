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
end
