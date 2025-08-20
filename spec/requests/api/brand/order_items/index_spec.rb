require 'rails_helper'

RSpec.describe Api::Brand::OrderItemsController, type: :request do
  describe "GET /api/brand/order_items" do
    let!(:user) { create(:user, :brand) }
    let!(:customer_user) { create(:user, :customer) }
    let!(:products) { create_list(:product, 3, brand: user.brand) }
    let!(:order) { create(:order, customer: customer_user.customer) }
    let!(:order_items) { create_list(:order_item, 4, order:, product: products.first) }

    before do
      order_items.first.update(product: products.second, status: 'shipped')
      order_items.second.update(product: products.third)
      order_items.third.update(product: products.third, status: 'shipped')
    end

    subject do
      get '/api/brand/order_items',
        headers: { Authorization: get_auth_token(user) },
        params:
    end

    context "When brand fetches order items for their products" do
      let!(:params) { }

      it "returns all the order items" do
        subject
        expect(json.size).to eq(4)
      end
    end

    context "When status filter is applied" do
      let!(:params) { { status: 'shipped' } }
      
      it "returns based on status filter" do
        subject
        statuses = json.pluck('status')
        expect(json.size).to eq(2)
        expect(statuses.all?('shipped')).to be(true)
      end
    end

    context "When product_id filter is applied" do
      let!(:params) { { product_id: products.third.id } }
      
      it "returns based on product IDs filter" do
        subject
        
        ids = json.map { |i| i['product']['id'] }
        expect(json.size).to eq(2)
        expect(ids.all?(products.third.id)).to be(true)
      end
    end

    context "When user who is not a brand tries to fetch" do
      let!(:params) { }

      subject do
        get '/api/brand/order_items',
          headers: { Authorization: get_auth_token(customer_user) },
          params:
      end

      it "returns unauthorised action error" do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end      
    end
  end
end
