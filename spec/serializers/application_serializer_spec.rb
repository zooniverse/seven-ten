RSpec.describe ApplicationSerializer, type: :serializer do
  let(:model) do
    Class.new(ActiveModelSerializers::Model) do
      attr_accessor :id, :attr1, :attr2
    end
  end

  let(:serializer) do
    Class.new(ApplicationSerializer) do
      attributes :id, :attr1, :attr2
      belongs_to :something
      belongs_to :something_else

      filterable_by :id, :attr1
      sortable_by :attr1, :attr2
      default_sort_by :id
      include_by_default :something, :something_else
    end
  end

  describe '.attributes' do
    subject{ ApplicationSerializer.new model.new(id: 1, attr1: 'nope') }
    its(:as_json){ is_expected.to eql id: 1 }
  end

  describe '.filterable_attributes' do
    subject{ serializer.filterable_attributes }
    it{ is_expected.to match_array [:id, :attr1] }
  end

  describe '.sortable_attributes' do
    subject{ serializer.sortable_attributes }
    it{ is_expected.to match_array [:id, :attr1, :attr2] }
  end

  describe '.default_sort' do
    subject{ serializer.default_sort }
    it{ is_expected.to eql :id }
  end

  describe '.default_includes' do
    subject{ serializer.default_includes }
    it{ is_expected.to eql 'something,something_else' }
  end
end
