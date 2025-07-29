module Api
  module Brand
    class ProductPolicy < ApplicationPolicy
      def create?
        user.brand?
      end

      def update?
        user.brand? && record_related?
      end

      def destroy?
        user.brand? && record_related?
      end

      private

      def record_related?
        record.brand == user.brand
      end
    end
  end
end
