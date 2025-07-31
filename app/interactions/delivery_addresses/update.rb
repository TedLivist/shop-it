module DeliveryAddresses
  class Update < Base
    object :delivery_address, class: DeliveryAddress
    object :customer, class: Customer

    string :phone_number, :description, :first_name, :last_name, default: nil
    boolean :is_default, default: nil

    validate :validate_default_value

    def execute
      DeliveryAddress.transaction do
        delivery_address.update(delivery_address_params)
      end
    end
  end
end
