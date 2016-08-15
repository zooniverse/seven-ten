class ApplicationController < ActionController::Base
  include Paginatable
  include Sortable

  class << self
    attr_accessor :resource, :serializer_class
  end

  attr_reader :current_user
  before_action :set_format, :set_user

  def root
    render json: { }
  end


  def resource
    self.class.resource
  end

  def serializer_class
    self.class.serializer_class
  end

  def resource_ids
    if params[:id].is_a? String
      list = params[:id].split(',').compact
      list.collect(&:to_i).reject(&:zero?).uniq
    else
      Array.wrap params.fetch(:id, [])
    end
  end

  def set_format
    request.format = :json if request.format == :json_api
  end

  def set_user
    @current_user = User.from_jwt Authenticator.from_headers request.headers
  end
end
