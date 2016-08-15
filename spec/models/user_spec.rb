RSpec.describe User, type: :model do
  context 'validating' do
    it 'should require a login' do
      without_login = build :user, login: nil
      expect(without_login).to fail_validation login: "can't be blank"
    end
  end

  describe '.from_jwt' do
    subject{ User.from_jwt data }

    context 'without a valid payload' do
      let(:data){ { } }
      it{ is_expected.to be_nil }
    end

    context 'with a valid payload' do
      let(:data){ { 'id' => 1, 'login' => 'login' } }
      its(:id){ is_expected.to eql 1 }
      its(:login){ is_expected.to eql 'login' }
    end
  end
end
