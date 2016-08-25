# TO-DO: add sidekiq worker to expire/transition state
class Split < ApplicationRecord
  has_many :variants
  has_many :split_user_variants
  has_many :users, through: :split_user_variants
  has_many :metrics, through: :split_user_variants
  belongs_to :project, required: true

  validates :name, presence: true
  validates :state, inclusion: {
    in: %w(inactive active complete),
    message: 'is not a valid state'
  }

  validates :key, presence: true

  validates :key, uniqueness: {
    scope: [:project_id, :state],
    if: :active?,
    message: "Only one split can be active on '%{value}' at a time"
  }

  before_create :set_ends_at

  scope :active, ->{ where state: 'active' }
  scope :expired, ->{ active.where 'ends_at < ?', Time.now.utc }
  scope :for_project, ->(project){ joins(:project).where 'projects.slug' => project.slug }

  def active?
    state == 'active'
  end

  def set_ends_at
    self.ends_at ||= 2.weeks.from_now.utc
  end
end
