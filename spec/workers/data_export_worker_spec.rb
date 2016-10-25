RSpec.describe DataExportWorker, type: :worker do
  let!(:data_request){ create :data_request }
  let(:worker){ DataExportWorker.new }

  it{ is_expected.to be_a Sidekiq::Worker }

  describe '#perform' do
    before(:each) do
      allow(worker).to receive :process_data
    end

    it 'should find the data request' do
      expect(DataRequest).to receive(:find).with(data_request.id)
        .and_return data_request
      worker.perform data_request.id
    end

    it 'should set the name' do
      worker.perform data_request.id
      expect(worker.name).to eql "split_#{ data_request.split_id }_metrics"
    end

    it 'should process the data' do
      expect(worker).to receive :process_data
      worker.perform data_request.id
    end
  end

  describe '#process_data' do
    before(:each) do
      worker.data_request = data_request
      worker.name = 'test'

      [:write_data, :compress, :upload, :remove].each do |name|
        allow(worker).to receive name
      end
    end

    it 'should write data' do
      expect(worker).to receive :write_data
      worker.process_data
    end

    it 'should compress the file' do
      expect(worker).to receive :compress
      worker.process_data
    end

    it 'should upload the file' do
      expect(worker).to receive :upload
      worker.process_data
    end

    it 'should set the data request as complete' do
      allow(worker).to receive(:upload).and_return 'a_url'
      expect(data_request).to receive(:update_attributes)
        .with url: 'a_url', state: 'complete'
      worker.process_data
    end

    it 'should remove the files' do
      expect(worker).to receive(:remove).with 'test.csv', 'test.tar.gz'
      worker.process_data
    end

    it 'should handle failure' do
      allow(worker).to receive(:upload).and_raise 'oops'
      expect(data_request).to receive(:update_attributes).with state: 'failed'
      expect{ worker.process_data }.to raise_error 'oops'
    end
  end

  describe '#write_data' do
    let(:converter){ double write: true }

    before(:each) do
      worker.name = 'test'
      allow(worker).to receive :metric_data
    end

    it 'should convert the data to csv' do
      expect(CsvConverter).to receive(:new).and_return converter
      worker.write_data
    end

    it 'should write the csv file' do
      allow(CsvConverter).to receive(:new).and_return converter
      expect(converter).to receive(:write).with 'test.csv'
      worker.write_data
    end
  end

  describe '#metric_data' do
    let(:metric){ create :metric }

    it 'should find the split metrics' do
      expect(worker).to receive(:metrics).and_return [metric]
      worker.metric_data
    end

    it 'should format the data' do
      allow(worker).to receive(:metrics).and_return [metric]
      suv = metric.split_user_variant
      expect(worker.metric_data).to eql([{
        id: metric.id,
        user_id: suv.user_id,
        metric: metric.key,
        metric_data: metric.value,
        created_at: metric.created_at,
        split_id: suv.split.id,
        split_key: suv.split.key,
        split_name: suv.split.name,
        variant_id: suv.variant.id,
        variant_name: suv.variant.name
      }])
    end
  end

  describe '#metrics' do
    let(:sorted_double){ double all: [] }
    let(:query_double){ double order: sorted_double }
    let(:preload_double){ double where: query_double }

    before(:each) do
      allow(Metric).to receive(:eager_load).and_return preload_double
      worker.data_request = data_request
    end

    it 'should eager load associations' do
      expect(Metric).to receive(:eager_load)
        .with(split_user_variant: [:split, :variant])
        .and_return preload_double
      worker.metrics
    end

    it 'should scope to the split' do
      expect(preload_double).to receive(:where)
        .with('split_user_variants.split_id' => data_request.split_id)
        .and_return query_double
      worker.metrics
    end

    it 'should order the results' do
      expect(query_double).to receive(:order)
        .with(:created_at)
        .and_return sorted_double
      worker.metrics
    end
  end

  describe '#compress' do
    before(:each){ worker.name = 'test' }

    it 'should call tar' do
      expect(worker).to receive(:`).with 'tar czf test.tar.gz test.csv'
      worker.compress
    end
  end

  describe '#upload' do
    let(:uploader){ double upload: true, url: true }
    let(:file){ double File }

    before(:each) do
      worker.name = 'test'
      allow(File).to receive(:new).with('test.tar.gz').and_return file
      expect(Uploader).to receive(:new).with(file).and_return uploader
    end

    it 'should upload the file' do
      expect(uploader).to receive :upload
      worker.upload
    end

    it 'should return the url' do
      expect(uploader).to receive(:url).and_return 'a_url'
      expect(worker.upload).to eql 'a_url'
    end
  end

  describe '#remove' do
    it 'should remove the files' do
      expect(File).to receive(:unlink).once.ordered.with 'foo'
      expect(File).to receive(:unlink).once.ordered.with 'bar'
      worker.remove 'foo', 'bar'
    end
  end
end
