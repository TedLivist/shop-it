module Api
  module Customer
    class DeliveryAddressesController < ApiController
      api :GET, '/api/customer/delivery_address', 'Create a delivery address'
      header :Authorization, 'Auth token', required: true
      param :delivery_address, Hash do
        param :phone_number, String, 'Recipient phone number', required: true
        param :description, String, 'Description of address', required: true
        param :first_name, String, 'First name of recipient', required: true
        param :last_name, String, 'Last name of recipient', required: true
        param :is_default, [true], 'Make address default (only true is the accepted value)', required: false
      end

      def create
        authorize @current_user, policy_class: Customer::DeliveryAddressPolicy
        payload = params.fetch(:delivery_address, {}).merge(customer: current_user.customer)
        result = DeliveryAddresses::Create.run(payload)
        respond_with result
      end
    end
  end
end
