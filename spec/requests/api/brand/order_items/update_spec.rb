require 'rails_helper'

RSpec.describe Api::Brand::OrderItemsController, type: :request do
  describe "PUT /api/brand/order_items/:id" do
    let!(:user) { create(:user, :brand) }
    
    let!(:product) { create(:product, brand: user.brand) }
    let!(:order) { create(:order) }
    let!(:order_items) { create_list(:order_item, 3, order:, product:) }

    subject do
      put "/api/brand/order_items/#{order_items.first.id}",
      headers: { Authorization: get_auth_token(user) },
      params:
    end

    context "When valid status is sent" do
      let!(:params) { { status: 'processing' } }

      it "updates the status of the order to partly shiped" do
        expect(order_items.first.status).to eq('pending')
        subject
        expect(order_items.first.reload.status).to eq('processing')
        expect(json['status']).to eq('processing')
      end
    end

    context "When invalid status" do
      let!(:params) { { status: 'invalid_status' } }

      it "returns invalid status error" do
        subject
        expect(json['errors']['status']).to eq(['is invalid'])
      end
    end

    context "If after update all items are cancelled" do
      let!(:params) { { status: 'cancelled' } }

      before do
        order_items.second.update(status: 'cancelled')
        order_items.third.update(status: 'cancelled')
      end
      
      it "updates the status of the order to cancelled" do
        subject
        expect(OrderItem.all.pluck(:status).all?('cancelled')).to be(true)
        expect(order.reload.status).to eq('cancelled')
      end
    end
    
    context "If after update all items are delivered" do
      let!(:params) { { status: 'delivered' } }
      
      before do
        order.update(status: 'shipped')
        order_items.second.update(status: 'delivered')
        order_items.third.update(status: 'delivered')
      end

      it "updates the status of the order to delivered" do
        subject
        expect(OrderItem.all.pluck(:status).all?('delivered')).to be(true)
        expect(order.reload.status).to eq('delivered')
      end
    end

    context "If after update some items are delivered" do
      let!(:params) { { status: 'delivered' } }
      
      before do
        order.update(status: 'shipped')
        order_items.second.update(status: 'delivered')
        order_items.third.update(status: 'shipped')
      end

      it "updates the status of the order to partly delivered" do
        subject
        expect(OrderItem.all.pluck(:status).any?('delivered')).to be(true)
        expect(order.reload.status).to eq('partly_delivered')
      end
    end

    context "If after update all items are shipped" do
      let!(:params) { { status: 'shipped' } }
      
      before do
        order.update(status: 'processing')
        order_items.second.update(status: 'shipped')
        order_items.third.update(status: 'shipped')
      end

      it "updates the status of the order to shipped" do
        subject
        expect(OrderItem.all.pluck(:status).all?('shipped')).to be(true)
        expect(order.reload.status).to eq('shipped')
      end
    end
    
    context "If after update some items are shipped" do
      let!(:params) { { status: 'shipped' } }
      
      before do
        order.update(status: 'processing')
        order_items.second.update(status: 'processing')
        order_items.third.update(status: 'shipped')
      end

      it "updates the status of the order to partly shipped" do
        subject
        expect(OrderItem.all.pluck(:status).any?('shipped')).to be(true)
        expect(order.reload.status).to eq('partly_shipped')
      end
    end

    context "If after update some items are processing" do
      let!(:params) { { status: 'processing' } }
      
      before do
        order.update(status: 'pending')
        order_items.second.update(status: 'processing')
        order_items.third.update(status: 'pending')
      end

      it "updates the status of the order to processing" do
        subject
        expect(OrderItem.all.pluck(:status).any?('processing')).to be(true)
        expect(order.reload.status).to eq('processing')
      end
    end
  end
end
