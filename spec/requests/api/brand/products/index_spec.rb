require 'rails_helper'

RSpec.describe Api::Brand::ProductsController, type: :request do
  describe 'POST #index' do
    let!(:user) { create(:user, :brand) }
    let!(:products) { create_list(:product, 5, brand: user.brand, status: 'published') }
    let!(:user2) { create(:user, :brand) }
    let!(:products2) { create_list(:product, 3, brand: user2.brand) }

    before do
      products.first.update(status: 'unpublished')
      products.third.update(status: 'unpublished')
    end

    subject do
      get '/api/brand/products',
          headers: { Authorization: get_auth_token(user) },
          params:
    end

    context 'When brand requests all their products' do
      let!(:params) { {} }

      it 'returns only their products' do
        expect(Product.count).to eq(8)
        subject
        expect(json.size).to eq(5)
      end
    end

    context 'When status filter is applied' do
      let!(:params) { { status: 'unpublished' } }

      it 'returns only the products with the status' do
        subject
        expect(json.size).to eq(2)
      end
    end
  end
end
