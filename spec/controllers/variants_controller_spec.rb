RSpec.describe VariantsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_behaves_like 'a controller authorizing'
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:split_id]

  it_has_behavior_of 'an authenticated user' do
    let(:current_user){ create :user, :admin }
    it_behaves_like 'a controller rendering'
  end

  it_behaves_like 'a controller creating' do
    let(:split){ create :split }
    let(:authorized_user){ create :user, :admin }
    let(:valid_params) do
      {
        data: {
          attributes: {
            name: 'works',
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

  it_behaves_like 'a controller updating' do
    let(:authorized_user){ create :user, :admin }
    let(:variant){ create :variant }
    let(:valid_params) do
      {
        id: variant.id.to_s,
        data: {
          id: variant.id.to_s,
          attributes: {
            name: 'changed'
          }
        }
      }
    end
  end
end
