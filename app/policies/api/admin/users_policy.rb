module Api
  module Admin
    class UsersPolicy < ApplicationPolicy
      def filtered?
        user.super_admin?
      end

      def update?
        user.super_admin?
      end
    end
  end
end
