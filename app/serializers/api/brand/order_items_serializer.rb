module Api
  module Brand
    class OrderItemsSerializer < ApplicationSerializer
      attributes :id, :quantity, :unit_price, :status, :product, :order

      def product
        return unless object.product

        {
          id: object.product.id,
          name: object.product.name,
          image_url: object.product.image_url,
          brand_id: object.product.id
        }
      end

      def order
        return unless object.order

        {
          id: object.order.id,
          delivery_address: object.order.delivery_address,
          delivery_phone_number: object.order.delivery_phone_number,
          delivery_recipient_name: object.order.delivery_recipient_name
        }
      end
    end
  end
end
