class AddStartsAtToSplits < ActiveRecord::Migration[5.0]
  def change
    add_column :splits, :starts_at, :datetime
  end
end
