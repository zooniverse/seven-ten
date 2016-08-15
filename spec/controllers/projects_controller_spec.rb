RSpec.describe ProjectsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_behaves_like 'a controller authorizing'
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:slug]
  it_behaves_like 'a controller rendering'
end
