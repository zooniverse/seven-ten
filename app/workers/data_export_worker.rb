require 'uploader'
require 'csv_converter'

class DataExportWorker
  include Sidekiq::Worker
  attr_accessor :data_request, :name

  sidekiq_options retry: true, backtrace: true

  def perform(data_request_id)
    self.data_request = ::DataRequest.find data_request_id
    self.name = "split_#{ data_request.split_id }_metrics"
    process_data
  end

  def process_data
    write_data
    compress
    url = upload
    data_request.update_attributes url: url, state: 'complete'
    remove "#{ name }.csv", "#{ name }.tar.gz"
  rescue => e
    data_request.update_attributes state: 'failed'
    raise e
  end

  def write_data
    converter = CsvConverter.new metric_data
    converter.write "#{ name }.csv"
  end

  def metric_data
    metrics.map do |metric|
      suv = metric.split_user_variant
      data = {
        id: metric.id,
        user_id: suv.user_id,
        metric: metric.key,
        metric_data: metric.value,
        created_at: metric.created_at,
        split_id: suv.split.id,
        split_key: suv.split.key,
        split_name: suv.split.name,
        variant_id: suv.variant.id,
        variant_name: suv.variant.name
      }
    end
  end

  def metrics
    ::Metric.eager_load(split_user_variant: [:split, :variant])
      .where('split_user_variants.split_id' => data_request.split_id)
      .order(:created_at)
      .all
  end

  def compress
    `tar czf #{ name }.tar.gz #{ name }.csv`
  end

  def upload
    uploader = ::Uploader.new ::File.new("#{ name }.tar.gz")
    uploader.upload
    uploader.url
  end

  def remove(*files)
    files.each{ |file| ::File.unlink file }
  end
end
