RSpec.describe ApplicationSchema, type: :schema do
  it 'should include JSON::SchemaBuilder' do
    expect(ApplicationSchema.ancestors).to include JSON::SchemaBuilder
  end

  describe '.inherited' do
    subject{ Class.new ApplicationSchema }
    its(:root_key){ is_expected.to eql :data }
  end
end
