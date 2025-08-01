module Api
  class DeliveryAddressSerializer < ApplicationSerializer
    attributes :id, :phone_number, :description, :first_name, :last_name, :customer_id, :is_default
  end
end
