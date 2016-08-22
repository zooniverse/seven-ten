RSpec.describe MetricPolicy, type: :policy do
  let(:user){ }
  let(:records){ create :metric }
  subject{ MetricPolicy.new user, records }

  context 'without a user' do
    it_behaves_like 'a policy forbidding', :index, :show, :create, :update, :destroy
  end

  context 'with a user' do
    let(:user){ create :user }
    it_behaves_like 'a policy permitting', :index
    it_behaves_like 'a policy forbidding', :show, :create, :update, :destroy
  end

  context 'with the metric user' do
    let(:user){ records.user }
    it_behaves_like 'a policy permitting', :index, :create
    it_behaves_like 'a policy forbidding', :show, :update, :destroy
  end

  context 'with an admin' do
    let(:user){ create :user, :admin }
    it_behaves_like 'a policy permitting', :index, :show
    it_behaves_like 'a policy forbidding', :create, :update, :destroy
  end
end
