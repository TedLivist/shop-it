require 'rails_helper'

RSpec.describe Api::ProductsController, type: :request do
  describe 'GET /api/products' do
    let!(:products) { create_list(:product, 5, status: 'published') }

    subject do
      get '/api/products',
          params:
    end

    context 'When no filters are applied' do
      subject do
        get '/api/products'
      end

      before do
        products.first.update(status: 'unpublished')
      end

      it 'returns all (published) products' do
        subject
        expect(json.size).to eq(4)
      end
    end

    context 'When name filter is applied' do
      let!(:params) do
        {
          name: 'maqz'
        }
      end

      before do
        products.first.update(name: 'Maqzkam')
        products.last.update(name: 'Maqzzza')
      end

      it 'returns results based on product name' do
        subject
        expect(json.size).to eq(2)
      end
    end

    context 'When brand name filter is applied' do
      let!(:params) do
        {
          brand_name: 'jaqw'
        }
      end

      before do
        products.first.brand.update(name: 'Jaqwiek')
        products.last.brand.update(name: 'Quine Jaqw')
        products.second.brand.update(name: 'Yajaqw LLC')
      end

      it 'returns results based on brand name' do
        subject
        expect(json.size).to eq(3)
      end
    end

    context 'When category name filter is applied' do
      let!(:params) do
        {
          category_name: 'Electo'
        }
      end

      before do
        products.first.category.update(name: 'Electoy')
        products.last.category.update(name: 'Relecto')
      end

      it 'returns results based on category name' do
        subject
        expect(json.size).to eq(2)
      end
    end
  end
end
