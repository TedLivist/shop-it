module Api
  module Customer
    class DeliveryAddressPolicy < ApplicationPolicy
      def create?
        user.customer?
      end
    end
  end
end
