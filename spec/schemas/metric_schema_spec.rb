RSpec.describe MetricSchema, type: :schema do
  describe '#create' do
    let(:schema_method){ :create }
    its(:type){ is_expected.to eql 'object' }
    its(:required){ is_expected.to eql ['data'] }

    with 'properties .data' do
      its(:type){ is_expected.to eql 'object' }
      its(:required){ is_expected.to match_array %w(split_user_variant_id key value) }
      its(:additionalProperties){ is_expected.to be false }

      with :properties do
        its(:split_user_variant_id){ is_expected.to eql id_schema }
        its(:key){ is_expected.to eql type: 'string' }

        with :value do
          its(:type){ is_expected.to eql 'object' }
          its(:additionalProperties){ is_expected.to be true }
        end
      end
    end
  end
end
