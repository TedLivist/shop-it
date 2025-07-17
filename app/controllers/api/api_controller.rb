module Api
  class ApiController < ::ApplicationController
    include ::Api::Errors
    respond_to :json
    self.responder = ::ApplicationResponder
  end
end
