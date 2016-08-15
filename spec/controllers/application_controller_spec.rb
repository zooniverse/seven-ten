RSpec.describe ApplicationController, type: :controller do
  it_behaves_like 'a controller authenticating', :root

  describe '#root' do
    subject{ response }

    context 'with application/json' do
      before(:each){ get :root, format: :json }
      its(:content_type){ is_expected.to eql 'application/json' }
    end

    context 'with application/vnd.api+json' do
      before(:each){ get :root, format: :json_api }
      its(:content_type){ is_expected.to eql 'application/json' }
    end
  end
end
