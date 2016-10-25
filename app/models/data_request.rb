class DataRequest < ApplicationRecord
  belongs_to :split, required: true
  has_one :project, through: :split
  after_commit :export_later, on: :create

  def export_later
    DataExportWorker.perform_async id
  end
end
