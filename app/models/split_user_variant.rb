class SplitUserVariant < ApplicationRecord
  belongs_to :split, required: true
  belongs_to :user, required: true
  belongs_to :variant, required: true
end
