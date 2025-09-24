module Api
  module Customer
    class OrderSerializer < ApplicationSerializer
      attributes :id, :customer_id, :total_price, :status, :delivery_address, :delivery_phone_number, :delivery_recipient_name, :order_items

      def order_items
        return if object.order_items.nil?

        object.order_items.map do |order_item|
          {
            id: order_item.id,
            quantity: order_item.quantity,
            product_name: order_item.product.name,
            unit_price: order_item.unit_price,
            status: order_item.status
          }
        end
      end
    end
  end
end
