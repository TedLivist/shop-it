module Api
  class ApiController < ::ApplicationController
    include ::Api::Errors
    respond_to :json
    self.responder = ::ApplicationResponder
    include Pundit::Authorization

    attr_reader :current_user

    rescue_from Pundit::NotAuthorizedError, with: :unauthorized!
  end
end
