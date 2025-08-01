require 'rails_helper'

RSpec.describe Api::Brand::ProductsController, type: :request do
  describe 'PUT #update' do
    let!(:user) { create(:user, :customer) }
    let!(:product) { create(:product) }

    let!(:image) { fixture_file_upload(file_fixture('second_product.jpg'), 'image/jpeg') }

    let!(:params) do
      {
        product: {
          name: Faker::Commerce.product_name,
          status: 'unpublished'
        }
      }
    end

    subject do
      put "/api/brand/products/#{product.id}",
          headers: { Authorization: get_auth_token(user) },
          params:
    end

    context 'When a customer tries to update a product' do
      it 'returns unauthorized error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end
    end

    context 'When product is unrelated to the brand user' do
      let!(:user) { create(:user, :brand) }
      let!(:second_user) { create(:user, :brand) }
      let!(:product) { create(:product, brand: user.brand) }

      subject do
        put "/api/brand/products/#{product.id}",
            headers: { Authorization: get_auth_token(second_user) },
            params:
      end

      it 'return unauthorized error' do
        subject
        expect(json['error']).to eq('That action is not authorized')
      end
    end

    context 'When status and name are requested for update' do
      let!(:user) { create(:user, :brand) }
      let!(:product) { create(:product, brand: user.brand, status: 'published') }

      it 'updates the name and status' do
        expect(product.name).to_not eq(params[:product][:name])
        expect(product.status).to_not eq(params[:product][:status])
        subject
        product.reload
        expect(product.name).to eq(params[:product][:name])
        expect(product.status).to eq(params[:product][:status])
      end
    end

    context 'When image is requested for update' do
      let!(:user) { create(:user, :brand) }
      let!(:product) { create(:product, brand: user.brand) }

      let!(:params) do
        {
          product: {
            image: image
          }
        }
      end

      it 'updates the image' do
        initial_url = product.image_url
        subject
        product.reload
        expect(product.image_url).to_not eq(initial_url)
      end
    end
  end
end
