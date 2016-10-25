RSpec.describe DataRequestSerializer, type: :serializer do
  let!(:data_request){ create :data_request }
  let(:json) do
    ActiveModelSerializers::SerializableResource.new(
      DataRequest.all,
      include: DataRequestSerializer.default_includes
    ).as_json
  end

  describe '.filterable_attributes' do
    subject{ DataRequestSerializer.filterable_attributes }
    it{ is_expected.to match_array [:split_id, :'projects.slug'] }
  end

  describe '.sortable_attributes' do
    subject{ DataRequestSerializer.sortable_attributes }
    it{ is_expected.to eql [:id] }
  end

  describe '.default_sort' do
    subject{ DataRequestSerializer.default_sort }
    it{ is_expected.to eql :id }
  end

  describe '#attributes' do
    subject{ json.dig :data, 0, :attributes }
    its([:split_id]){ is_expected.to eql data_request.split_id }
    its([:state]){ is_expected.to eql data_request.state }
    its([:url]){ is_expected.to eql data_request.url }
    its([:created_at]){ is_expected.to eql data_request.created_at }
    its([:updated_at]){ is_expected.to eql data_request.updated_at }
  end

  describe '#links' do
    subject{ json.dig :data, 0, :links }
    its([:self]){ is_expected.to eql "/data_requests/#{ data_request.id }" }
    its([:split]){ is_expected.to eql "/splits/#{ data_request.split_id }" }
  end
end
