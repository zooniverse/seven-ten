RSpec.describe SplitsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_behaves_like 'a controller authorizing'
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:project_id, :state]
  it_behaves_like 'a controller rendering'
end
