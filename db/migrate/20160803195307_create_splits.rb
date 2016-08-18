class CreateSplits < ActiveRecord::Migration[5.0]
  def change
    create_table :splits do |t|
      t.string :name, null: false
      t.string :key, null: false
      t.string :state, null: false, default: 'inactive'
      t.index :state
      t.belongs_to :project, null: false, foreign_key: true
      t.datetime :ends_at, null: false
      t.timestamps

      # only allow one split on a key to be active at a time
      t.index [:key, :state, :project_id], unique: true, where: "state = 'active'"
    end
  end
end
