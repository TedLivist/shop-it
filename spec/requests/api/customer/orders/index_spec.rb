require 'rails_helper'

RSpec.describe Api::Customer::OrdersController, type: :request do
  describe 'GET /api/customer/orders' do
    let!(:user) { create(:user, :customer) }
    let!(:orders) { create_list(:order, 2, customer: user.customer) }
    let!(:order_items1) { create_list(:order_item, 5, order: orders.first) }
    let!(:order_items2) { create_list(:order_item, 3, order: orders.second) }

    subject do
      get '/api/customer/orders',
          headers: { Authorization: get_auth_token(user) }
    end

    context 'When request to fetch orders is made' do
      it 'returns the customers orders' do
        subject
        expect(json.size).to eq(2)
      end

      it 'returns the order items too' do
        subject
        expect(json[0]['order_items'].size).to eq(5)
        expect(json[1]['order_items'].size).to eq(3)
      end
    end
  end
end
