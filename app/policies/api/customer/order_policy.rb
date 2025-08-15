module Api
  module Customer
    class OrderPolicy < ApplicationPolicy
      def create?
        user.customer?
      end
    end
  end
end
