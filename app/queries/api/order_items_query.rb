module Api
  class OrderItemsQuery < ApplicationQuery
    def call
      status = options[:status]
      product_id = options[:product_id]
      brand = options[:brand]

      scope = brand.order_items
      scope = scope.where(status:) if status.present?
      scope = scope.where(product_id:) if product_id.present?
       
      scope
    end
  end
end