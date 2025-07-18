require 'rails_helper'

RSpec.describe Api::User::BrandAuthController, type: :request do
  describe '/api/user/brand_sign_up' do
    let!(:user_role) { create(:user_role, name: :brand) }

    context 'When valid parameters are provided' do
      let!(:params) do
        {
          user: {
            email: Faker::Internet.email,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            password: '12345678',
            password_confirmation: '12345678'
          }
        }
      end

      subject do
        post '/api/user/brand_sign_up', params:
      end

      it 'Sign user up succesfully' do
        subject
        expect(response).to have_http_status(:success)
        expect(json['message']).to eq('account created')
      end

      it 'creates the user' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'creates a brand record' do
        expect { subject }.to change(Brand, :count).by(1)
      end

      it 'create user as a brand' do
        subject
        user = User.first
        expect(user.brand?).to be(true)
      end
    end
  end
end
