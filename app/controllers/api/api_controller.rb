module Api
  class ApiController < ::ApplicationController
    include ::Api::Errors
    respond_to :json
    self.responder = ::ApplicationResponder
    
    include Pundit::Authorization
  
    rescue_from Pundit::NotAuthorizedError, with: :unauthorized!

    def current_user
      @current_user
    end
  end
end
