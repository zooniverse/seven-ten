class Project < ApplicationRecord
  has_many :data_requests
  has_many :metrics
  has_many :split_user_variants
  has_many :splits
  has_many :variants
  validates :slug, presence: true
end
