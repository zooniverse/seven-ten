class AddProjectIds < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_requests, :project, null: false, index: true, foreign_key: true
    add_reference :metrics, :project, null: false, index: true, foreign_key: true
    add_reference :split_user_variants, :project, null: false, index: true, foreign_key: true
    add_reference :variants, :project, null: false, index: true, foreign_key: true
  end
end
