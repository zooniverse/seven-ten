RSpec.describe SplitsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_behaves_like 'a controller authorizing'
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:project_id, :state]
  it_behaves_like 'a controller rendering'

  it_behaves_like 'a controller creating' do
    let(:project){ create :project }
    let(:authorized_user){ create :user, admin: true }
    let(:valid_params) do
      {
        data: {
          attributes: {
            name: 'works',
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
end
