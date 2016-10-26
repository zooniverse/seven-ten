RSpec.describe SplitUserVariantPolicy, type: :policy do
  let(:user){ }
  let(:records){ create :split_user_variant }
  subject{ SplitUserVariantPolicy.new user, records }

  context 'without a user' do
    it_behaves_like 'a policy forbidding', :index, :show, :create, :update, :destroy
  end

  context 'with a user' do
    let(:user){ create :user }
    it_behaves_like 'a policy permitting', :index
    it_behaves_like 'a policy forbidding', :show, :create, :update, :destroy
  end

  context 'with the owner' do
    let(:user){ records.user }
    it_behaves_like 'a policy permitting', :index, :show
    it_behaves_like 'a policy forbidding', :create, :update, :destroy
  end

  context 'with an admin' do
    let(:user){ create :user, :admin }
    it_behaves_like 'a policy permitting', :index
    it_behaves_like 'a policy forbidding', :show, :create, :update, :destroy
  end

  context 'with a project owner' do
    let(:user){ create :user, roles: { records.id => ['owner'] } }
    it_behaves_like 'a policy permitting', :index
    it_behaves_like 'a policy forbidding', :show, :create, :update, :destroy
  end

  context 'with a project collaborator' do
    let(:user){ create :user, roles: { records.id => ['collaborator'] } }
    it_behaves_like 'a policy permitting', :index
    it_behaves_like 'a policy forbidding', :show, :create, :update, :destroy
  end

  describe SplitUserVariantPolicy::Scope do
    let!(:other_records){ create_list :split_user_variant, 2 }
    let(:user){ create :user }
    let!(:records){ create_list :split_user_variant, 2, user: user }
    subject{ SplitUserVariantPolicy::Scope.new(user, SplitUserVariant).resolve }

    it{ is_expected.to match_array records }
  end
end
