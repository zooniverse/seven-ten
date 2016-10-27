class Metric < ApplicationRecord
  belongs_to :project, required: true
  belongs_to :split_user_variant, required: true
  has_one :user, through: :split_user_variant

  before_validation :set_project, on: :create
  validates :key, presence: true

  def set_project
    self.project = split_user_variant&.project
  end
end
