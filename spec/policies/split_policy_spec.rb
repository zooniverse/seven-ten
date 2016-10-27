RSpec.describe SplitPolicy, type: :policy do
  let(:user){ }
  let(:records){ create :split }
  subject{ SplitPolicy.new user, records }

  context 'without a user' do
    it_behaves_like 'a policy permitting', :index, :show
    it_behaves_like 'a policy forbidding', :create, :update, :destroy
  end

  context 'with a user' do
    let(:user){ create :user }
    it_behaves_like 'a policy permitting', :index, :show
    it_behaves_like 'a policy forbidding', :create, :update, :destroy
  end

  context 'with an admin' do
    let(:user){ create :user, :admin }
    it_behaves_like 'a policy permitting', :index, :show, :create, :update, :destroy
  end

  context 'with a project owner' do
    let(:user){ create :user, roles: { records.project.id => ['owner'] } }
    it_behaves_like 'a policy permitting', :index, :show, :create, :update, :destroy
  end

  context 'with a project collaborator' do
    let(:user){ create :user, roles: { records.project.id => ['collaborator'] } }
    it_behaves_like 'a policy permitting', :index, :show, :create, :update, :destroy
  end

  describe SplitPolicy::Scope do
    let(:project){ create :project }
    let!(:other_records){ create_list :split, 2 }
    let(:user){ create :user, roles: { project.id => ['owner'] } }
    let!(:records){ create_list :split, 2, project: project }
    subject{ SplitPolicy::Scope.new(user, Split).resolve }

    it{ is_expected.to match_array records }
  end
end
