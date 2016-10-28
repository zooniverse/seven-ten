class SplitTransitionWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, backtrace: true

  def perform
    transition Split.pending, state: 'active'
    transition Split.expired, state: 'complete'
  end

  def transition(splits, state:)
    splits.each do |split|
      split.update_attributes state: state
    end
  end
end
