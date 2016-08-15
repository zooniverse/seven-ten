class Project < ApplicationRecord
  validates :slug, presence: true
end
