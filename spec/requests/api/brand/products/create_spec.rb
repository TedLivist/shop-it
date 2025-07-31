require 'rails_helper'

RSpec.describe Api::Brand::ProductsController, type: :request do
  describe 'POST #create' do
    let!(:user) { create(:user) }
    let!(:customer) { create(:customer, user:) }
    let!(:category) { create(:category) }

    let!(:image) { fixture_file_upload(file_fixture('first_product.jpg'), 'image/jpeg') }

    let!(:params) do
      {
        product: {
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.sentence,
          price: Faker::Commerce.price,
          stock: Faker::Number.between(from: 1, to: 10),
          status: Product.statuses.keys.sample,
          image: image,
          category_id: category.id
        }
      }
    end

    subject do
      post '/api/brand/products',
           headers: { Authorization: get_auth_token(user) },
           params:
    end

    context 'When a customer tries to create a product' do
      it 'returns unauthorized error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end
    end

    context 'When category does not exist' do
      let!(:user) { create(:user, :brand) }

      let!(:params) do
        {
          product: {
            name: Faker::Commerce.product_name,
            description: Faker::Lorem.sentence,
            price: Faker::Commerce.price,
            stock: Faker::Number.between(from: 1, to: 10),
            status: Product.statuses.keys.sample,
            image: image,
            category_id: category.id + 1
          }
        }
      end

      subject do
        post '/api/brand/products',
             headers: { Authorization: get_auth_token(user) },
             params:
      end

      it 'returns category not found error' do
        subject
        expect(json['errors']['category']).to eq(['not found'])
      end
    end

    context 'When params are all valid' do
      let!(:user) { create(:user, :brand) }

      it 'creates the product' do
        expect { subject }.to change(Product, :count).by(1)
      end
    end
  end
end
