class AddWeightToVariants < ActiveRecord::Migration[5.0]
  def change
    add_column :variants, :weight, :integer
  end
end
