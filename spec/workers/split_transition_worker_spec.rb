RSpec.describe SplitTransitionWorker, type: :worker do
  let(:worker){ SplitTransitionWorker.new }

  it{ is_expected.to be_a Sidekiq::Worker }

  describe '#perform' do
    let!(:inactive){ create :split, starts_at: 1.day.from_now }
    let!(:pending){ create :split, state: 'inactive', starts_at: 1.day.ago }
    let!(:active){ create :split, state: 'active' }
    let!(:expired){ create :split, state: 'active', ends_at: 1.day.ago }

    it 'should activate pending splits' do
      expect{
        worker.perform
      }.to change {
        pending.reload.active?
      }.to true
    end

    it 'should complete expired splits' do
      expect{
        worker.perform
      }.to change {
        expired.reload.active?
      }.to false
    end

    it 'should not modify other splits' do
      expect{
        worker.perform
      }.to_not change {
        [active, inactive].map(&:reload).map &:state
      }
    end
  end
end
