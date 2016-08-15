RSpec.describe ApplicationController, type: :controller do
  describe '#root' do
    subject{ response }

    context 'with application/json' do
      before(:each){ get :root, format: :json }
      its(:content_type){ is_expected.to eql 'application/json' }
    end
  end
end
