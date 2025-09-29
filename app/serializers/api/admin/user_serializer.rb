module Api
  module Admin
    class UserSerializer < ApplicationSerializer
      attributes :id, :first_name, :last_name, :email, :status, :user_role

      def user_role
        return unless object.user_role.present?

        {
          id: object.user_role.id,
          name: object.user_role.name
        }
      end
    end
  end
end
