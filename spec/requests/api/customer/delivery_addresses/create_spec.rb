require 'rails_helper'

RSpec.describe Api::Customer::DeliveryAddressesController, type: :request do
  describe 'POST #create' do
    let!(:user) { create(:user, :customer) }
    let!(:brand_user) { create(:user, :brand) }

    let!(:params) do
      {
        delivery_address: {
          phone_number: Faker::PhoneNumber.phone_number,
          description: Faker::Lorem.sentence,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          is_default: true
        }
      }
    end

    subject do
      post '/api/customer/delivery_address',
           headers: { Authorization: get_auth_token(user) },
           params:
    end

    context 'When all values are valid' do
      it 'creates the delivery address' do
        expect { subject }.to change(DeliveryAddress, :count).by(1)
      end
    end

    context 'Non-customer tries to create a delivery address' do
      subject do
        post '/api/customer/delivery_address',
             headers: { Authorization: get_auth_token(brand_user) },
             params:
      end

      it 'returns unauthorized action error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end

      it 'does not create the delivery address' do
        expect { subject }.to change(DeliveryAddress, :count).by(0)
      end
    end

    context 'When is_default parameter is false' do
      let!(:params) do
        {
          delivery_address: {
            phone_number: Faker::PhoneNumber.phone_number,
            description: Faker::Lorem.sentence,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            is_default: false
          }
        }
      end

      it 'returns is_default must be true or vacant error' do
        subject
        expect(json['errors']['is_default']).to eq(['Must be true or left vacant'])
      end
    end
  end
end
