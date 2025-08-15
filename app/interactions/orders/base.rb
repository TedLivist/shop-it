module Orders
  class Base < ApplicationInteraction
    attr_reader :order, :product, :stock, :products, :items, :delivery_address

    def to_model
      order.reload
    end

    def validate_products_and_stock
      product_ids = order_items.pluck(:product_id)
      @products = Product.where(id: product_ids).index_by(&:id)

      order_items.map do |order_item|
        product = products[order_item[:product_id]]

        unless product
          errors.add(:product, :not_found)
          throw(:abort)
        end

        next if product.stock >= order_item[:quantity]

        errors.add(
          :stock,
          :not_enough,
          product_name: product.name
        )
        throw(:abort)
      end
    end

    def validate_delivery_address
      @delivery_address = customer.delivery_addresses.find_by(id: delivery_address_id)

      unless @delivery_address
        errors.add(:delivery_address, :not_found)
        throw(:abort)
      end
    end

    private

    def update_products_stocks
      order_items.map do |order_item|
        product = products[order_item[:product_id]]

        updated_stock = product.stock - order_item[:quantity]
        unless product.update(stock: updated_stock)
          errors.merge!(:product, product.errors)
          throw(:abort)
        end
      end
    end

    def order_items_params
      @items = []

      order_items.map do |order_item|
        product = products[order_item[:product_id]]
        order_item.merge!(unit_price: product.price, status: 'unprocessed')
        items.push(order_item)
      end

      items
    end
  end
end
