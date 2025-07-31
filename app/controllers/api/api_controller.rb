module Api
  class ApiController < ::ApplicationController
    include ::Api::Errors
    respond_to :json
    self.responder = ::ApplicationResponder
    include Pundit::Authorization

    attr_reader :current_user

    rescue_from Pundit::NotAuthorizedError, with: :unauthorized_action!

    private

    def unauthorized_action!
      render json: { error: 'That action is not authorized' }, status: :unauthorized
    end
  end
end
