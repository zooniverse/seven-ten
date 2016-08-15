RSpec.describe VariantSchema, type: :schema do
  shared_examples_for 'a variant schema' do
    its(:type){ is_expected.to eql 'object' }
    its(:required){ is_expected.to eql ['data'] }

    with 'properties .data' do
      its(:type){ is_expected.to eql 'object' }
      its(:additionalProperties){ is_expected.to be false }

      with :properties do
        its(:split_id){ is_expected.to eql id_schema }
        its(:name){ is_expected.to eql type: 'string' }
        its(:key){ is_expected.to eql type: 'string' }

        with :value do
          its(:type){ is_expected.to eql 'object' }
          its(:properties){ is_expected.to eql({ }) }
          its(:additionalProperties){ is_expected.to be true }
        end
      end
    end
  end

  describe '#create' do
    let(:schema_method){ :create }
    it_behaves_like 'a variant schema'

    with 'properties .data' do
      its(:required){ is_expected.to eql %w(split_id name key value) }
    end
  end

  describe '#update' do
    let(:schema_method){ :update }
    it_behaves_like 'a variant schema'

    with 'properties .data' do
      its(:required){ is_expected.to be_nil }
    end
  end
end
