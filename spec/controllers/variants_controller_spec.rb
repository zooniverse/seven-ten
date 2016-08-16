RSpec.describe VariantsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_behaves_like 'a controller authorizing'
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:key, :split_id]
  it_behaves_like 'a controller rendering'

  it_behaves_like 'a controller creating' do
    let(:split){ create :split }
    let(:authorized_user){ create :user, admin: true }
    let(:valid_params) do
      {
        data: {
          attributes: {
            name: 'works',
            key: 'test',
            value: {
              text: 'also works'
            }
          }, relationships: {
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
