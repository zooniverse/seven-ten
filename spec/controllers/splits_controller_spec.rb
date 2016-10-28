RSpec.describe SplitsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_behaves_like 'a controller authorizing'
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:project_id, :state]

  it_has_behavior_of 'an authenticated user' do
    let(:split){ create :split }
    let(:current_user){ create :user, roles: { split.project_id => ['owner'] } }

    it_behaves_like 'a controller rendering' do
      let!(:resource_instance){ split }
    end
  end

  it_behaves_like 'a controller creating' do
    let(:project){ create :project }
    let(:authorized_user){ create :user, :admin }
    let(:valid_params) do
      {
        data: {
          attributes: {
            name: 'works',
            key: 'something',
            state: 'inactive',
          }, relationships: {
            project: {
              data: {
                type: 'projects',
                id: project.id.to_s
              }
            }
          }
        }
      }
    end
  end

  it_behaves_like 'a controller updating' do
    let(:authorized_user){ create :user, :admin }
    let(:split){ create :split }
    let(:valid_params) do
      {
        id: split.id.to_s,
        data: {
          id: split.id.to_s,
          attributes: {
            name: 'changed',
            starts_at: Time.now.as_json
          }
        }
      }
    end
  end
end
