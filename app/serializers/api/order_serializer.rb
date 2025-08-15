module Api
  class OrderSerializer < ApplicationSerializer
    attributes :id, :customer_id, :total_price, :status, :delivery_address, :delivery_phone_number, :delivery_recipient_name
  end
end
