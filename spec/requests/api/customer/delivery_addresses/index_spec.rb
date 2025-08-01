require 'rails_helper'

RSpec.describe Api::Customer::DeliveryAddressesController, type: :request do
  describe 'GET /api/customer/delivery_addresses' do
    let!(:user) { create(:user, :customer) }

    subject do
      get '/api/customer/delivery_addresses',
          headers: { Authorization: get_auth_token(user) }
    end

    context 'When a non-customer tried to fetch delivery addresses' do
      let!(:user) { create(:user, :brand) }
      let!(:delivery_address) { create(:delivery_address) }

      it 'returns unauthorized action error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end
    end

    context 'When customer tries to fetch their delivery addresses' do
      let!(:second_user) { create(:user, :customer) }
      let!(:delivery_addresses) { create_list(:delivery_address, 5, customer: user.customer) }
      let!(:second_addresses) { create_list(:delivery_address, 3, customer: second_user.customer) }

      subject do
        get '/api/customer/delivery_addresses',
            headers: { Authorization: get_auth_token(second_user) }
      end

      it 'returns only their delivery addresses' do
        subject
        expect(DeliveryAddress.count).to eq(8)
        expect(json.size).to eq(3)
      end
    end
  end
end
