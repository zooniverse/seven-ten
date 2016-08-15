class ApplicationController < ActionController::Base
  attr_reader :current_user
  before_action :set_format, :set_user

  def root
    render json: { }
  end

  def set_format
    request.format = :json if request.format == :json_api
  end

  def set_user
    @current_user = User.from_jwt Authenticator.from_headers request.headers
  end
end
