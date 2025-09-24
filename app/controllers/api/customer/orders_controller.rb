module Api
  module Customer
    class OrdersController < ApiController
      api :POST, '/api/customer/orders', 'Create an order'
      header :Authorization, 'Auth token', required: true
      param :order, Hash do
        param :delivery_address_id, Integer, 'Delivery address ID', required: true
        param :order_items, Array, 'Order items array', required: true do
          param :product_id, Integer, 'Product ID', required: true
          param :quantity, Integer, 'Quantity of Product', required: true
        end
      end

      def create
        authorize @current_user, policy_class: Customer::OrderPolicy
        payload = params.fetch(:order, {}).merge(customer: current_user.customer)
        result = Orders::Create.run(payload)
        respond_with result, serializer: Api::OrderSerializer
      end

      api :GET, '/api/customer/orders', 'Get list of customer orders'
      header :Authorization, 'Auth token', required: true

      def index
        authorize @current_user, policy_class: Customer::OrderPolicy
        customer = @current_user.customer
        result = customer.orders
        respond_with result
      end
    end
  end
end
