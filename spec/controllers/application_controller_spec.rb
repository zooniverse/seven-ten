RSpec.describe ApplicationController, type: :controller do
  it_behaves_like 'a controller authenticating', :root
  it_behaves_like 'a controller paginating'

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

  describe '#resource_ids' do
    let(:params){ { } }
    let(:controller_params){ ActionController::Parameters.new params }

    subject{ controller.resource_ids }

    before(:each) do
      allow(controller).to receive(:params).and_return controller_params
    end

    context 'without an id' do
      it{ is_expected.to be_empty }
    end

    context 'with an integer' do
      let(:params){ { id: 123 } }
      it{ is_expected.to eql [123] }
    end

    context 'with a single id string' do
      let(:params){ { id: '123' } }
      it{ is_expected.to eql [123] }
    end

    context 'with a comma separated string' do
      let(:params){ { id: '123,456' } }
      it{ is_expected.to eql [123, 456] }
    end

    context 'with a mess' do
      let(:params){ { id: ',;,123,456.123,\'foo\'' } }
      it{ is_expected.to eql [123, 456] }
    end
  end
end
