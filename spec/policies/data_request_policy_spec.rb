RSpec.describe DataRequestPolicy, type: :policy do
  let(:user){ }
  let(:records){ create :data_request }
  subject{ DataRequestPolicy.new user, records }

  context 'without a user' do
    it_behaves_like 'a policy forbidding', :index, :show, :create, :update, :destroy
  end

  context 'with a user' do
    let(:user){ create :user }
    it_behaves_like 'a policy permitting', :index
    it_behaves_like 'a policy forbidding', :show, :create, :update, :destroy
  end

  context 'with an admin' do
    let(:user){ create :user, :admin }
    it_behaves_like 'a policy permitting', :index, :show, :create
    it_behaves_like 'a policy forbidding', :update, :destroy
  end

  context 'with a project owner' do
    let(:user){ create :user, roles: { records.project.id => ['owner'] } }
    it_behaves_like 'a policy permitting', :index, :show, :create
    it_behaves_like 'a policy forbidding', :update, :destroy
  end

  context 'with a project collaborator' do
    let(:user){ create :user, roles: { records.project.id => ['collaborator'] } }
    it_behaves_like 'a policy permitting', :index, :show, :create
    it_behaves_like 'a policy forbidding', :update, :destroy
  end

  describe DataRequestPolicy::Scope do
    let(:split){ create :split }
    let!(:other_records){ create_list :data_request, 2 }
    let(:user){ create :user, roles: { split.project_id => ['owner'] } }
    let!(:records){ create_list :data_request, 2, split: split }
    subject{ DataRequestPolicy::Scope.new(user, DataRequest).resolve }

    it{ is_expected.to match_array records }
  end
end
