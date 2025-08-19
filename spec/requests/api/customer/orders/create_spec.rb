require 'rails_helper'

RSpec.describe Api::Customer::OrdersController, type: :request do
  describe 'POST /api/customer/orders' do
    let!(:user) { create(:user, :customer) }
    let!(:brand_user) { create(:user, :brand) }
    let!(:delivery_address) { create(:delivery_address, customer: user.customer) }
    let!(:products) { create_list(:product, 4, stock: 3) }

    let!(:params) do
      {
        order: {
          delivery_address_id: delivery_address.id,
          order_items: [
            { product_id: products.first.id, quantity: 2 },
            { product_id: products.second.id, quantity: 3 },
            { product_id: products.third.id, quantity: 2 }
          ]
        }
      }
    end

    subject do
      post '/api/customer/orders',
           headers: { Authorization: get_auth_token(user) },
           params:,
           as: :json
    end

    context 'When all values are valid' do
      it 'creates the order and order items' do
        expect { subject }
          .to change(Order, :count).by(1)
                                   .and change(OrderItem, :count).by(3)
      end

      it 'returns the created order' do
        subject
        expect(json['id']).to eq(Order.first.id)
        expect(json['customer_id']).to eq(user.customer.id)
      end

      it 'updates the stock of the affected products' do
        initial_stocks = [products.first.stock, products.second.stock, products.third.stock]
        expect(initial_stocks).to eq([3, 3, 3])
        subject
        updated_stocks = [
          products.first.reload.stock,
          products.second.reload.stock,
          products.third.reload.stock
        ]
        expect(updated_stocks).to eq([1, 0, 1])
      end

      it 'sets the order and order items to pending statuses' do
        subject
        order = Order.first
        order_status = order.status
        items_statuses = order.order_items.pluck(:status)
        expect(order_status).to eq('pending')
        expect(items_statuses.all?('pending')).to be(true)
      end
    end

    context 'When non-customer tries to create an order' do
      subject do
        post '/api/customer/orders',
             headers: { Authorization: get_auth_token(brand_user) },
             params:
      end

      it 'returns unauthorized action error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end

      it 'does not create the order' do
        expect { subject }.to change(Order, :count).by(0)
      end
    end

    context 'When any of the products does not exist' do
      let!(:params) do
        {
          order: {
            delivery_address_id: delivery_address.id,
            order_items: [
              { product_id: products.first.id, quantity: 2 },
              { product_id: products.third.id + 100, quantity: 2 }
            ]
          }
        }
      end

      it 'returns product not found error' do
        subject
        expect(json['errors']['product']).to eq(['not found'])
      end
    end

    context 'When any of the product quantities is more than stock' do
      let!(:params) do
        {
          order: {
            delivery_address_id: delivery_address.id,
            order_items: [
              { product_id: products.first.id, quantity: 2 },
              { product_id: products.third.id, quantity: 5 }
            ]
          }
        }
      end

      it 'returns product stock not enough error' do
        subject
        expect(json['errors']['stock']).to eq([I18n.t('active_interaction.errors.models.orders/create.attributes.stock.not_enough',
                                                      attribute: 'Stock', product_name: products.third.name)])
      end
    end

    context 'When delivery address does not exist' do
      let!(:params) do
        {
          order: {
            delivery_address_id: delivery_address.id + 1,
            order_items: [
              { product_id: products.first.id, quantity: 2 },
              { product_id: products.second.id, quantity: 3 },
              { product_id: products.third.id, quantity: 2 }
            ]
          }
        }
      end

      it 'returns delivery address not found error' do
        subject
        expect(json['errors']['delivery_address']).to eq(['not found'])
      end
    end
  end
end
