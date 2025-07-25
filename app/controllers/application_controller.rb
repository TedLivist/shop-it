require 'application_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  
  def authenticate_user!
    return unauthorized! if !payload || !AuthenticationTokenService.valid_payload?(payload.first)

    current_user!
    unauthorized! unless @current_user
  end

  def current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  
  
  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split.last
    AuthenticationTokenService.decode(token)
  rescue StandardError
    nil
  end

  def unauthorized!
    render json: { error: t('api.errors.unauthorized') }, status: :unauthorized
  end
end
