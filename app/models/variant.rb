class Variant < ApplicationRecord
  belongs_to :split, required: true
  has_many :split_user_variants
  has_many :users, through: :split_user_variants

  validates :name, presence: true
  validates :key, presence: true
  validates :value, presence: true
end
