require 'rails_helper'

RSpec.describe Api::Brand::ProductsController, type: :request do
  describe 'DELETE #destroy' do
    let!(:user) { create(:user, :customer) }
    let!(:product) { create(:product) }

    subject do
      delete "/api/brand/products/#{product.id}",
             headers: { Authorization: get_auth_token(user) }
    end

    context 'When a customer tries to delete a product' do
      it 'returns unauthorized error' do
        subject
        expect(json['error']).to eq('Unauthorized')
      end
    end

    context 'When product is unrelated to the brand user' do
      let!(:user) { create(:user, :brand) }
      let!(:second_user) { create(:user, :brand) }

      it 'return unauthorized error' do
        subject
        expect(json['error']).to eq('Unauthorized')
      end
    end

    context 'When product does not exist' do
      let!(:user) { create(:user, :brand) }

      subject do
        delete "/api/brand/products/#{product.id + 1}",
               headers: { Authorization: get_auth_token(user) }
      end

      it 'returns not found error message' do
        subject
        expect(json['error']).to eq('Not Found')
      end
    end

    context 'When image and present belongs to user' do
      let!(:user) { create(:user, :brand) }
      let!(:products) { create_list(:product, 3, brand: user.brand) }

      subject do
        delete "/api/brand/products/#{products.first.id}",
               headers: { Authorization: get_auth_token(user) }
      end

      it 'deletes the product' do
        expect(user.brand.products.size).to eq(3)
        subject
        expect(user.brand.products.size).to eq(2)
        expect(json['product']).to eq('deleted')
      end
    end
  end
end
