module OrderItems
  class Base < ApplicationInteraction
    attr_reader :order_item

    def to_model
      order_item.reload
    end

    def validate_status
      unless OrderItem.statuses.keys.any?(status)
        errors.add(:status, :invalid)
        throw(:abort)
      end
    end
  end
end
