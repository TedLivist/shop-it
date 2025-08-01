module DeliveryAddresses
  class Create < Base
    object :customer, class: Customer
    string :phone_number, :description, :first_name, :last_name
    boolean :is_default, default: nil

    validate :validate_default_value

    def execute
      DeliveryAddress.transaction do
        @delivery_address = customer.delivery_addresses.build(delivery_address_params)
        set_initial_default

        save_or_rollback(@delivery_address)
      end
    end

    private

    # if the delivery address is the first one being created for the customer
    # then it should be set to true regardless of the request not including it
    # rubocop:disable Style/CollectionQuerying
    def set_initial_default
      @delivery_address.is_default = true if inputs[:is_default].nil? && customer.delivery_addresses.count.zero?
    end
    # rubocop:enable Style/CollectionQuerying
  end
end
