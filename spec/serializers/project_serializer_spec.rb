RSpec.describe ProjectSerializer, type: :serializer do
  let!(:project){ create :project }
  let(:json) do
    ActiveModelSerializers::SerializableResource.new(Project.all).as_json
  end

  describe '.filterable_attributes' do
    subject{ ProjectSerializer.filterable_attributes }
    it{ is_expected.to match_array [:slug] }
  end

  describe '.sortable_attributes' do
    subject{ ProjectSerializer.sortable_attributes }
    it{ is_expected.to be_empty }
  end

  describe '.default_sort' do
    subject{ ProjectSerializer.default_sort }
    it{ is_expected.to be_empty }
  end

  describe '#attributes' do
    subject{ json.dig :data, 0, :attributes }
    its([:slug]){ is_expected.to eql project.slug }
  end

  describe '#links' do
    subject{ json.dig :data, 0, :links }
    its([:self]){ is_expected.to eql "/projects/#{ project.id }" }
    its([:splits]){ is_expected.to eql "/splits?filter%5Bproject_id%5D=#{ project.id }" }
  end
end
