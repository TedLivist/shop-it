module Api
  module Brand
    class ProductPolicy < ApplicationPolicy
      def create?
        user.brand?
      end

      def update?
        user.brand? && brand_record_related?
      end

      def destroy?
        user.brand? && brand_record_related?
      end
    end
  end
end
