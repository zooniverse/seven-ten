class CreateDataRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :data_requests do |t|
      t.belongs_to :split, null: false, foreign_key: { on_delete: :cascade }
      t.string :state, default: 'pending'
      t.string :url
      t.timestamps
    end
  end
end
