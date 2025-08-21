require 'rails_helper'

RSpec.describe Api::Brand::MetricsController, type: :request do
  describe 'GET api/brand/metrics/sales_summary' do
    let!(:user) { create(:user, :brand) }
    let!(:products) { create_list(:product, 3, brand: user.brand) }
    let!(:order_items) { create_list(:order_item, 5, product: products.first, unit_price: 2) }

    let!(:user2) { create(:user, :brand) }
    let!(:product2) { create(:product, brand: user2.brand) }

    before do
      order_items.first.update(product: products.second, quantity: 4)
      order_items.third.update(product: products.third, quantity: 7)

      order_items.fourth.update(product: product2, quantity: 4)
    end

    subject do
      get '/api/brand/metrics/sales_summary',
          headers: { Authorization: get_auth_token(user) }
    end

    context 'When brand request sales summary' do
      it 'accurately returns the total sales and orders' do
        subject
        expect(json['total_sales'].to_i).to eq(26)
        expect(json['total_orders']).to eq(4)
      end
    end
  end
end
