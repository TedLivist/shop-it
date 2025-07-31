module DeliveryAddresses
  class Create < Base
    object :customer, class: Customer
    string :phone_number, :description, :first_name, :last_name
    boolean :is_default, default: nil

    validate :validate_default_value

    def execute
      DeliveryAddress.transaction do
        @delivery_address = customer.delivery_addresses.build(delivery_address_params)

        save_or_rollback(@delivery_address)
      end
    end

    def to_model
      { message: 'delivery address created' }
    end
  end
end
