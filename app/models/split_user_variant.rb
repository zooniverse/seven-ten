class SplitUserVariant < ApplicationRecord
  has_many :metrics
  belongs_to :project, required: true
  belongs_to :split, required: true
  belongs_to :user, required: true
  belongs_to :variant, required: true

  before_validation :set_project, on: :create

  def set_project
    self.project = split&.project
  end
end
