require 'rails_helper'

RSpec.describe Api::ProductsController, type: :request do
  describe 'GET /api/products/:id' do
    let!(:product) { create(:product) }

    context 'When product exists' do
      subject do
        get "/api/products/#{product.id}"
      end

      it 'returns the product' do
        subject
        expect(json['id']).to eq(product.id)
        expect(json['brand']['name']).to eq(product.brand.name)
      end
    end

    context 'When product does not exist' do
      subject do
        get "/api/products/#{product.id + 1}"
      end

      it 'returns not found error' do
        subject
        expect(json['error']).to eq('Not Found')
      end
    end
  end
end
