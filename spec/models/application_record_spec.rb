RSpec.describe ApplicationRecord, type: :model do
  describe '#with_retry' do
    let(:record){ create :split }
    let(:block){ double }
    subject do
      record.with_retry(error: RuntimeError, attempts: 2){ block.call }
    end

    def expect_call
      expect(block).to receive(:call).once.ordered
    end

    context 'with an intermittent exception' do
      before(:each) do
        expect_call.and_raise 'error'
        expect_call.and_return 'worked'
      end

      it 'should succeed' do
        expect(subject).to eql 'worked'
      end
    end

    context 'with a persistent exception' do
      before(:each) do
        expect_call.and_raise 'error'
        expect_call.and_raise 'error'
      end

      it 'should re-raise the error' do
        expect{ subject }.to raise_error 'error'
      end
    end

    context 'with an unspecified exception' do
      before(:each) do
        expect_call.and_raise TypeError.new 'oops'
      end

      it 'should not retry' do
        expect{ subject }.to raise_error TypeError
      end
    end
  end
end
