module Api
  module User
    class AuthSerializer < ApplicationSerializer
      attributes :id, :email, :full_name, :status, :brand_id, :customer_id, :is_admin, :user_role, :token

      delegate :full_name, to: :object

      def brand_id
        return unless object.brand?

        object.brand&.id
      end

      def customer_id
        return unless object.customer?

        object.customer&.id
      end

      def is_admin
        object.super_admin?
      end

      def user_role
        return unless object.user_role

        {
          id: object.user_role.id,
          name: object.user_role.name
        }
      end

      def token
        AuthenticationTokenService.call(object.id)
      end
    end
  end
end
