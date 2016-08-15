class Project < ApplicationRecord
  has_many :splits
  validates :slug, presence: true
end
