RSpec.describe DataRequestsController, type: :controller do
  before(:each) do
    allow(controller).to receive :set_roles
  end

  it_behaves_like 'a controller authenticating'
  it_has_behavior_of 'an authenticated user' do
    it_behaves_like 'a controller authorizing'
  end
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:split_id, :'projects.slug']
  it_has_behavior_of 'an authenticated user' do
    let(:current_user){ create :user, :admin  }
    it_behaves_like 'a controller rendering'
  end

  it_behaves_like 'a controller creating' do
    let(:split){ create :split }
    let(:authorized_user){ create :user, :admin }
    let(:valid_params) do
      {
        data: {
          attributes: { },
          relationships: {
            split: {
              data: {
                type: 'splits',
                id: split.id.to_s
              }
            }
          }
        }
      }
    end
  end
end
