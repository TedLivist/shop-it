module Orders
  class Create < Base
    object :customer, class: Customer
    array :order_items
    integer :delivery_address_id

    validate :validate_products_and_stock, :validate_delivery_address

    def execute
      Order.transaction do
        update_products_stocks
        order_items_params
        total = items.sum { |i| i[:quantity] * i[:unit_price] }

        @order = customer.orders.build(
          total_price: total,
          delivery_address: delivery_address.description, delivery_phone_number: delivery_address.phone_number,
          delivery_recipient_name: delivery_address.full_name,
          order_items_attributes: order_items_params
        )

        save_or_rollback(@order)
      end
    end
  end
end
