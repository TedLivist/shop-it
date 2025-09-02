module Api
  module Brand
    class ProductsQuery < ApplicationQuery
      def call
        status = options[:status]
        brand = options[:brand]

        scope = brand.products.order(created_at: :desc)
        scope = scope.where(status:) if status.present?
        scope
      end
    end
  end
end
