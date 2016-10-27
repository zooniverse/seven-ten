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

  describe '#set_project' do
    let(:split){ create :split }
    subject{ build :data_request, split: split }

    context 'when creating' do
      it 'should be called before validation' do
        expect(subject).to receive :set_project
        subject.save
      end
    end

    context 'when updating' do
      it 'should not be called' do
        subject.save
        expect(subject).to_not receive :set_project
        subject.update_attributes url: 'test'
      end
    end

    it 'should set the project' do
      expect{
        subject.set_project
      }.to change{
        subject.project
      }.to split.project
    end
  end
end
