RSpec.describe VariantSerializer, type: :serializer do
  let!(:variant){ create :variant }
  let(:json) do
    ActiveModelSerializers::SerializableResource.new(Variant.all).as_json
  end

  describe '.filterable_attributes' do
    subject{ VariantSerializer.filterable_attributes }
    it{ is_expected.to match_array [:key, :split_id] }
  end

  describe '.sortable_attributes' do
    subject{ VariantSerializer.sortable_attributes }
    it{ is_expected.to be_empty }
  end

  describe '.default_sort' do
    subject{ VariantSerializer.default_sort }
    it{ is_expected.to eql :id }
  end

  describe '#attributes' do
    subject{ json.dig :data, 0, :attributes }
    its([:name]){ is_expected.to eql variant.name }
    its([:key]){ is_expected.to eql variant.key }
    its([:value]){ is_expected.to eql variant.value }
    its([:split_id]){ is_expected.to eql variant.split_id }
  end

  describe '#links' do
    subject{ json.dig :data, 0, :links }
    its([:self]){ is_expected.to eql "/variants/#{ variant.id }" }
    its([:split]){ is_expected.to eql "/splits/#{ variant.split_id }" }
  end
end
