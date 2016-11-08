class Variant < ApplicationRecord
  belongs_to :project, required: true
  belongs_to :split, required: true
  has_many :split_user_variants
  has_many :users, through: :split_user_variants
  has_many :metrics, through: :split_user_variants

  before_validation :set_project, on: :create
  validates :name, presence: true
  validates :value, presence: true

  def set_project
    self.project = split&.project
  end

  def unweighted?
    weight.nil?
  end
end
