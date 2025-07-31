module Api
  module Customer
    class DeliveryAddressesController < ApiController
      api :POST, '/api/customer/delivery_address', 'Create a delivery address'
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
        respond_with result, serializer: Api::DeliveryAddressSerializer
      end

      api :PUT, '/api/customer/delivery_addresses/:id', 'Update a delivery address'
      header :Authorization, 'Auth token', required: true
      param :id, Integer, 'ID of delivery address', required: true
      param :delivery_address, Hash do
        param :phone_number, String, 'Recipient phone number', required: false
        param :description, String, 'Description of address', required: false
        param :first_name, String, 'First name of recipient', required: false
        param :last_name, String, 'Last name of recipient', required: false
        param :is_default, [true], 'Make address default (only true is the accepted value)', required: false
      end

      def update
        delivery_address = DeliveryAddress.find(params[:id])
        authorize delivery_address, policy_class: Customer::DeliveryAddressPolicy
        payload = params.fetch(:delivery_address, {}).merge(delivery_address:, customer: current_user.customer)
        result = DeliveryAddresses::Update.run(payload)
        respond_with result, serializer: Api::DeliveryAddressSerializer
      end
    end
  end
end
