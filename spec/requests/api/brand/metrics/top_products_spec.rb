require 'rails_helper'

RSpec.describe Api::Brand::MetricsController, type: :request do
  describe 'GET api/brand/metrics/top_products' do
    let!(:user) { create(:user, :brand) }
    let!(:products) { create_list(:product, 5, brand: user.brand) }
    let!(:order_items) { create_list(:order_item, 5, product: products.first, unit_price: 2) }

    before do
      order_items.second.update(product: products.second, quantity: 4)
      order_items.third.update(product: products.third, quantity: 7)
      order_items.fourth.update(product: products.fourth, quantity: 5)
    end

    subject do
      get '/api/brand/metrics/top_products',
          headers: { Authorization: get_auth_token(user) }
    end

    context 'When brand request top products' do
      it 'returns the top products' do
        subject
        ids = json.map { |i| i['id'] }

        expect(json.size).to eq(3)
        expect(ids == [products.third.id, products.fourth.id, products.second.id]).to be(true)
      end
    end
  end
end
