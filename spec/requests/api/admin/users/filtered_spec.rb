require 'rails_helper'

RSpec.describe Api::Admin::UsersController, type: :request do
  describe 'GET #filtered' do
    let!(:user) { create(:user, :super_admin) }
    let!(:brand_users) { create_list(:user, 3, :brand) }
    let!(:customer_users) { create_list(:user, 2, :customer) }

    before do
      brand_users.first.update(status: 'inactive')
      brand_users.second.update(status: 'inactive')
      brand_users.third.update(status: 'pending')

      customer_users.first.update(status: 'inactive')
      customer_users.second.update(status: 'inactive')
    end

    subject do
      get '/api/admin/users/filtered',
          headers: { Authorization: get_auth_token(user) },
          params:
    end

    context 'When requests pending brand users' do
      let!(:params) do
        {
          status: 'pending',
          user_role: 'brand'
        }
      end

      it 'returns the pending brands list' do
        subject
        expect(json.size).to eq(1)
      end
    end

    context 'When admin requests inactive brand users' do
      let!(:params) do
        {
          status: 'inactive',
          user_role: 'brand'
        }
      end

      it 'returns the inactive brands list' do
        subject
        expect(json.size).to eq(2)
      end
    end

    context 'When requests inactive customer users' do
      let!(:params) do
        {
          status: 'inactive',
          user_role: 'customer'
        }
      end

      it 'returns the inactive customers list' do
        subject
        expect(json.size).to eq(2)
      end
    end
  end
end
