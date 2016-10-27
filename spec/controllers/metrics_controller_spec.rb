RSpec.describe MetricsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_has_behavior_of 'an authenticated user' do
    it_behaves_like 'a controller authorizing'
  end
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:key, :split_user_variant_id]
  it_has_behavior_of 'an authenticated user' do
    let(:current_user){ create :user, :admin }
    it_behaves_like 'a controller rendering'
  end

  it_behaves_like 'a controller creating' do
    let(:authorized_user){ create :user }
    let(:split_user_variant){ create :split_user_variant, user: authorized_user }

    let(:valid_params) do
      {
        data: {
          attributes: {
            split_user_variant_id: split_user_variant.id,
            key: 'test',
            value: { test: true }
          }
        }
      }
    end
  end
end
