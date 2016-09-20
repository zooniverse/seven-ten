class AddMetricTypesToSplits < ActiveRecord::Migration[5.0]
  def change
    add_column :splits, :metric_types, :string, array: true, default: []
  end
end
