class CreateSplitUserVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :split_user_variants do |t|
      t.belongs_to :split, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :variant, null: false, foreign_key: { on_delete: :cascade }
    end
  end
end
