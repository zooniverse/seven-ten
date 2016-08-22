class CreateMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metrics do |t|
      t.belongs_to :split_user_variant, null: false, foreign_key: { on_delete: :cascade }
      t.string :key, null: false, index: true
      t.json :value, default: { }
      t.timestamps
    end
  end
end
