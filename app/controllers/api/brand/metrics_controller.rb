module Api
  module Brand
    class MetricsController < ApiController
      api :GET, '/api/brand/metrics/sales_summary', 'Fetch brand sales metrics'
      header :Authorization, 'Auth token', required: true

      def sales_summary
        authorize @current_user, policy_class: Brand::MetricsPolicy
        brand = @current_user.brand

        render json: {
          total_sales: brand.total_sales,
          total_orders: brand.order_items.count
        }
      end

      api :GET, '/api/brand/metrics/top_products', 'Fetch top 3 products in (sales quantity)'
      header :Authorization, 'Auth token', required: true

      def top_products
        authorize @current_user, policy_class: Brand::MetricsPolicy
        brand = @current_user.brand
        result = brand.top_products_by_quantity(3)
        respond_with result, each_serializer: Api::ProductSerializer
      end
    end
  end
end
