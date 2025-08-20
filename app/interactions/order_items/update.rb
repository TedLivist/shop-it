module OrderItems
  class Update < Base
    object :order_item, class: OrderItem
    string :status

    validate :validate_status

    def execute
      OrderItem.transaction do
        order_item.update(status:)
      end
    end
  end
end
