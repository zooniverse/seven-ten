RSpec.describe MetricSerializer, type: :serializer do
  let!(:metric){ create :metric }
  let(:json) do
    ActiveModelSerializers::SerializableResource.new(Metric.all).as_json
  end

  describe '.filterable_attributes' do
    subject{ MetricSerializer.filterable_attributes }
    it{ is_expected.to match_array [:key, :split_user_variant_id] }
  end

  describe '.sortable_attributes' do
    subject{ MetricSerializer.sortable_attributes }
    it{ is_expected.to eql [:id] }
  end

  describe '.default_sort' do
    subject{ MetricSerializer.default_sort }
    it{ is_expected.to eql :id }
  end

  describe '#attributes' do
    subject{ json.dig :data, 0, :attributes }
    its([:key]){ is_expected.to eql metric.key }
    its([:value]){ is_expected.to eql metric.value }
    its([:split_user_variant_id]){ is_expected.to eql metric.split_user_variant_id }
    its([:created_at]){ is_expected.to be_within(1.second).of metric.created_at }
  end

  describe '#links' do
    subject{ json.dig :data, 0, :links }
    its([:self]){ is_expected.to eql "/metrics/#{ metric.id }" }
  end
end
