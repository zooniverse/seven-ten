class Metric < ApplicationRecord
  has_one :project, through: :split_user_variant
  belongs_to :split_user_variant, required: true
  has_one :user, through: :split_user_variant
  validates :key, presence: true
end
