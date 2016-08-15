# TO-DO: add sidekiq worker to expire/transition state
class Split < ApplicationRecord
  has_many :variants
  belongs_to :project, required: true

  validates :name, presence: true
  validates :state, inclusion: {
    in: %w(inactive active complete),
    message: 'is not a valid state'
  }

  before_create :set_ends_at

  scope :active, ->{ where state: 'active' }
  scope :expired, ->{ active.where 'ends_at < ?', Time.now.utc }

  def set_ends_at
    self.ends_at ||= 2.weeks.from_now.utc
  end
end
