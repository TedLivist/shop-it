module Api
  module Brand
    class OrderItemsController < ApiController
      api :GET, '/api/brand/order_items', "Get all brand's order items"
      param :status, String, 'Order item status', required: false
      param :product_id, String, 'Product ID', required: false

      def index
        authorize @current_user, policy_class: Brand::OrderItemsPolicy
        order_items = Api::OrderItemsQuery.call(params.merge(brand: @current_user.brand))
        respond_with order_items, each_serializer: Api::Brand::OrderItemsSerializer
      end

      api :POST, '/api/brand/order_items/:id', 'Update order item status'
      header :Authorization, 'Auth token', required: true
      param :id, Integer, 'ID of product', required: true
      param :status, String, 'Order Item status', required: true

      def update
        order_item = OrderItem.find(params[:id])
        authorize order_item, policy_class: Brand::OrderItemsPolicy
        payload = params.permit(:status).merge(order_item:)
        result = OrderItems::Update.run(payload)
        respond_with result, serializer: Api::Brand::OrderItemsSerializer
      end
    end
  end
end
