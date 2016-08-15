RSpec.describe ApplicationPolicy, type: :policy do
  let(:user){ }
  let(:records){ [] }
  subject{ ApplicationPolicy.new user, records }

  describe 'default actions' do
    it_behaves_like 'a policy permitting', :index, :show
    it_behaves_like 'a policy forbidding', :create, :update, :destroy
  end

  context 'without a user' do
    it{ is_expected.to_not be_logged_in }
    it{ is_expected.to_not be_admin }
  end

  context 'with a user' do
    let(:user){ create :user }
    it{ is_expected.to be_logged_in }
    it{ is_expected.to_not be_admin }
  end

  context 'with an admin' do
    let(:user){ create :user, :admin }
    it{ is_expected.to be_logged_in }
    it{ is_expected.to be_admin }
  end

  pending 'with a project owner'
  pending 'with a project collaborator'
end
