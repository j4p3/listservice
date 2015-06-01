module TokenAuthentication
  extend ActiveSupport::Concern

  @@json_formats = [
    'application/json',
    'application/x-javascript',
    'text/javascript',
    'text/x-javascript',
    'text/x-json'
  ]

  included do
    skip_before_action :verify_authenticity_token, if: :json_request?
  end

  def filter
    request.headers["X-AUTHENTICATION-TOKEN"] == Rails.application.secrets.client_token
  end

private

  def json_request?
     @@json_formats.include? request.content_type
  end
end