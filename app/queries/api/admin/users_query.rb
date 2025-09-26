module Api
  module Admin
    class UsersQuery < ApplicationQuery
      def call
        user_role = options[:user_role]
        status = options[:status]

        scope = ::User.joins(:user_role)
        scope = scope.where(status:) if status.present?
        scope = scope.where(user_roles: { name: user_role }) if user_role.present?
        scope
      end
    end
  end
end
