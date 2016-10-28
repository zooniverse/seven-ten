RSpec.describe SplitSchema, type: :schema do
  shared_examples_for 'a split schema' do
    its(:type){ is_expected.to eql 'object' }
    its(:required){ is_expected.to eql ['data'] }

    with 'properties .data' do
      its(:type){ is_expected.to eql 'object' }
      its(:additionalProperties){ is_expected.to be false }

      with :properties do
        its(:project_id){ is_expected.to eql id_schema }
        its(:name){ is_expected.to eql type: 'string' }
        its(:key){ is_expected.to eql type: 'string' }
        its(:state){ is_expected.to eql enum: %w(inactive active complete) }
        its(:starts_at){ is_expected.to eql type: 'string', format: 'date-time' }
        its(:ends_at){ is_expected.to eql type: 'string', format: 'date-time' }
      end
    end
  end

  describe '#create' do
    let(:schema_method){ :create }
    it_behaves_like 'a split schema'

    with 'properties .data' do
      its(:required){ is_expected.to eql %w(project_id name key state) }
    end
  end

  describe '#update' do
    let(:schema_method){ :update }
    it_behaves_like 'a split schema'

    with 'properties .data' do
      its(:required){ is_expected.to be_nil }
    end
  end
end
