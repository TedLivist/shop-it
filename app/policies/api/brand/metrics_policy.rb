module Api
  module Brand
    class MetricsPolicy < ApplicationPolicy
      def sales_summary?
        user.brand?
      end

      def top_products?
        user.brand?
      end
    end
  end
end
