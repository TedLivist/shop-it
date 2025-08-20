module Api
  module Brand
    class OrderItemsPolicy < ApplicationPolicy
      def index?
        user.brand?
      end

      def update?
        user.brand? && brand_record_related?
      end

      private

      def brand_record_related?
        record.product.brand == user.brand
      end
    end
  end
end
