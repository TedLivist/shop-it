module Api
  class ApiController < ::ApplicationController
    include ::Api::Errors
    respond_to :json
    self.responder = ::ApplicationResponder

    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :unauthorized!

    attr_reader :current_user
  end
end
