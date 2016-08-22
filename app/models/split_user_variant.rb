class SplitUserVariant < ApplicationRecord
  has_many :metrics
  has_one :project, through: :split
  belongs_to :split, required: true
  belongs_to :user, required: true
  belongs_to :variant, required: true
end
