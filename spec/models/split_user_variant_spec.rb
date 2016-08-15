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
end
