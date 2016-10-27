class DataRequest < ApplicationRecord
  belongs_to :split, required: true
  belongs_to :project, required: true

  before_validation :set_project, on: :create
  after_commit :export_later, on: :create

  def export_later
    DataExportWorker.perform_async id
  end

  def set_project
    self.project = split&.project
  end
end
