module Api
  module Brand
    class OrderItemsController < ApiController
      
      api :GET, '/api/order_items', "Get all brand's order items"
      param :status, String, 'Order item status', required: false
      param :product_id, String, 'Product ID', required: false
      
      def index
        authorize @current_user, policy_class: Brand::OrderItemsPolicy
        order_items = Api::OrderItemsQuery.call(params.merge(brand: @current_user.brand))
        respond_with order_items, each_serializer: Api::Brand::OrderItemsSerializer
      end
    end
  end
end