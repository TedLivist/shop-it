module Api
  module Errors
    extend ActiveSupport::Concern
    included do
      rescue_from ActionController::ParameterMissing, with: :required_param!
      rescue_from AASM::InvalidTransition, with: :invalid_transition!
      rescue_from ActiveRecord::RecordNotFound, with: :not_found!

      def required_param!(exception)
        error_msg = format(t('api.errors.param_is_required'), attribute: exception.param)&.capitalize
        render json: { errors: { exception.param => error_msg } }, status: :bad_request
      end

      def invalid_transition!
        error_msg = t('api.errors.invalid_transition')
        render json: { error: error_msg }, status: :unprocessable_entity
      end

      def not_found!
        error_msg = t('api.errors.not_found')
        render json: { error: error_msg }, status: :not_found
      end
    end
  end
end
