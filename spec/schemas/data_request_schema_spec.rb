RSpec.describe DataRequestSchema, type: :schema do
  describe '#create' do
    let(:schema_method){ :create }
    its(:type){ is_expected.to eql 'object' }
    its(:required){ is_expected.to eql ['data'] }

    with 'properties .data' do
      its(:type){ is_expected.to eql 'object' }
      its(:required){ is_expected.to eql ['split_id'] }
      its(:additionalProperties){ is_expected.to be false }

      with :properties do
        its(:split_id){ is_expected.to eql id_schema }
      end
    end
  end
end
