require 'rails_helper'

RSpec.describe Api::Customer::DeliveryAddressesController, type: :request do
  describe 'PUT /api/customer/delivery_addresses/:id' do
    let!(:delivery_address) { create(:delivery_address) }

    let!(:params) do
      {
        delivery_address: {
          is_default: true
        }
      }
    end

    subject do
      put "/api/customer/delivery_addresses/#{delivery_address.id}",
          headers: { Authorization: get_auth_token(user) },
          params:
    end

    context 'When a non-customer tries to update a delivery address' do
      let!(:user) { create(:user, :brand) }

      it 'returns unauthorized action error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end
    end

    context 'When delivery address is unrelated to the customer' do
      let!(:second_user) { create(:user, :customer) }

      subject do
        put "/api/customer/delivery_addresses/#{delivery_address.id}",
            headers: { Authorization: get_auth_token(second_user) },
            params:
      end

      it 'return unauthorized action error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end
    end

    context 'When existing default delivery address exists and new request is_default is true' do
      let!(:user) { create(:user, :customer) }
      let!(:delivery_addresses) { create_list(:delivery_address, 4, customer: user.customer) }

      before do
        delivery_addresses.second.update(is_default: true)
      end

      subject do
        put "/api/customer/delivery_addresses/#{delivery_addresses.first.id}",
            headers: { Authorization: get_auth_token(user) },
            params:
      end

      it 'removes default from old record and sets new one to true' do
        initial_default_address = delivery_addresses.second
        newer_default_address = delivery_addresses.first
        expect(initial_default_address.is_default).to be(true)
        expect(newer_default_address.is_default).to be(false)

        subject
        initial_default_address.reload
        newer_default_address.reload

        expect(initial_default_address.is_default).to be(false)
        expect(newer_default_address.is_default).to be(true)
      end
    end

    context 'When other attributes are requested for update' do
      let!(:user) { create(:user, :customer) }
      let!(:delivery_address) { create(:delivery_address, phone_number: '2830827292', customer: user.customer) }
      let!(:params) do
        {
          delivery_address: {
            phone_number: Faker::PhoneNumber.phone_number,
            last_name: 'Yannick Kelvin'
          }
        }
      end

      subject do
        put "/api/customer/delivery_addresses/#{delivery_address.id}",
            headers: { Authorization: get_auth_token(user) },
            params:
      end

      it 'updates the attributes' do
        address = DeliveryAddress.first
        expect(address.phone_number).to eq(delivery_address.phone_number)
        expect(address.last_name).to_not eq(params[:delivery_address][:last_name])

        subject
        address.reload

        expect(address.phone_number).to eq(params[:delivery_address][:phone_number])
        expect(address.last_name).to eq(params[:delivery_address][:last_name])
      end
    end
  end
end
