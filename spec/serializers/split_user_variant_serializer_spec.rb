RSpec.describe SplitUserVariantSerializer, type: :serializer do
  let!(:split_user_variant){ create :split_user_variant }
  let(:json) do
    ActiveModelSerializers::SerializableResource.new(
      SplitUserVariant.all,
      include: SplitUserVariantSerializer.default_includes
    ).as_json
  end

  describe '.filterable_attributes' do
    subject{ SplitUserVariantSerializer.filterable_attributes }
    it{ is_expected.to match_array [:split_id, :'projects.slug'] }
  end

  describe '.sortable_attributes' do
    subject{ SplitUserVariantSerializer.sortable_attributes }
    it{ is_expected.to match_array [:id] }
  end

  describe '.default_sort' do
    subject{ SplitUserVariantSerializer.default_sort }
    it{ is_expected.to eql :id }
  end

  describe '.default_includes' do
    subject{ SplitUserVariantSerializer.default_includes }
    it{ is_expected.to eql 'split,variant' }
  end

  describe '#relationships' do
    subject{ json.dig :data, 0, :relationships }
    it{ is_expected.to have_key :split }
    it{ is_expected.to have_key :variant }
  end
  
  describe '#links' do
    subject{ json.dig :data, 0, :links }
    its([:self]){ is_expected.to eql "/split_user_variants/#{ split_user_variant.id }" }
    its([:split]){ is_expected.to eql "/splits/#{ split_user_variant.split_id }" }
    its([:variant]){ is_expected.to eql "/variants/#{ split_user_variant.variant_id }" }
  end

  describe '#included' do
    let(:split){ json[:included].find{ |record| record[:type] == 'splits' } }
    let(:variant){ json[:included].find{ |record| record[:type] == 'variants' } }

    it 'should include the split' do
      expect(split[:attributes][:name]).to eql split_user_variant.split.name
    end

    it 'should include the variant' do
      expect(variant[:attributes][:name]).to eql split_user_variant.variant.name
    end
  end
end
