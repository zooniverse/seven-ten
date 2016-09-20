RSpec.describe SplitSerializer, type: :serializer do
  let!(:split){ create :split, key: 'landing.text' }
  let(:json) do
    ActiveModelSerializers::SerializableResource.new(Split.all).as_json
  end

  describe '.filterable_attributes' do
    subject{ SplitSerializer.filterable_attributes }
    it{ is_expected.to match_array [:project_id, :key, :state] }
  end

  describe '.sortable_attributes' do
    subject{ SplitSerializer.sortable_attributes }
    it{ is_expected.to match_array [:id] }
  end

  describe '.default_sort' do
    subject{ SplitSerializer.default_sort }
    it{ is_expected.to eql :id }
  end

  describe '#attributes' do
    subject{ json.dig :data, 0, :attributes }
    its([:name]){ is_expected.to eql split.name }
    its([:key]){ is_expected.to eql split.key }
    its([:state]){ is_expected.to eql split.state }
    its([:project_id]){ is_expected.to eql split.project_id }
    its([:metric_types]){ is_expected.to match_array %w(classifier_visited classification_created) }
    its([:ends_at]){ is_expected.to be_within(1.minute).of split.ends_at }
  end

  describe '#links' do
    subject{ json.dig :data, 0, :links }
    its([:self]){ is_expected.to eql "/splits/#{ split.id }" }
    its([:variants]){ is_expected.to eql "/variants?filter%5Bsplit_id%5D=#{ split.id }" }
  end
end
