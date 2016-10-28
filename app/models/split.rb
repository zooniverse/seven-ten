class Split < ApplicationRecord
  include MetricTypes

  has_many :variants
  has_many :split_user_variants
  has_many :users, through: :split_user_variants
  has_many :metrics, through: :split_user_variants
  has_many :data_requests
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

  scope :inactive, ->{ where state: 'inactive' }
  scope :active, ->{ where state: 'active' }
  scope :pending, ->{ inactive.where 'starts_at < ?', Time.now.utc }
  scope :expired, ->{ active.where 'ends_at < ?', Time.now.utc }

  def assign_user(user)
    with_retry(attempts: 5, error: ActiveRecord::RecordNotUnique) do
      split_user_variants.where(user: user).first_or_create do |suv|
        suv.variant = variants.sample # or implement a weighted sampling
        suv.save!
      end
    end
  end

  def active?
    state == 'active'
  end

  def set_ends_at
    self.ends_at ||= 2.weeks.from_now.utc
  end
end
