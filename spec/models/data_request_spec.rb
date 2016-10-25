RSpec.describe DataRequest, type: :model do
  context 'validating' do
    it 'should require a split' do
      without_split = build :data_request, split: nil
      expect(without_split).to fail_validation split: 'must exist'
    end
  end

  describe '#export_later' do
    let(:data_request){ build :data_request }
    it 'should queue the worker' do
      expect(DataExportWorker).to receive(:perform_async).with data_request.id
      data_request.save
    end
  end
end
