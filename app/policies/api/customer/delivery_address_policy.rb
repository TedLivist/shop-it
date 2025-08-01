module Api
  module Customer
    class DeliveryAddressPolicy < ApplicationPolicy
      def create?
        user.customer?
      end

      def update?
        user.customer? && record_related?
      end

      def index?
        user.customer?
      end

      private

      def record_related?
        record.customer == user.customer
      end
    end
  end
end
