module Api
  module Admin
    class UsersPolicy < ApplicationPolicy
      def filtered?
        user.super_admin?
      end
    end
  end
end
