module Api
  module Customer
    class OrderPolicy < ApplicationPolicy
      def create?
        user.customer?
      end

      def index?
        user.customer?
      end
    end
  end
end
