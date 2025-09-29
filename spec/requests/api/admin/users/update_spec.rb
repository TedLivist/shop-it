require 'rails_helper'

RSpec.describe Api::Admin::UsersController, type: :request do
  describe 'GET #filtered' do
    let!(:user) { create(:user, :super_admin) }
    let!(:brand_user) { create(:user, :brand, status: "inactive") }

    subject do
      put "/api/admin/users/#{brand_user.id}",
      headers: { Authorization: get_auth_token(user) },
      params:
    end

    context "When user does not exist" do
      let!(:params) do
        {
          status: "activate"
        }
      end

      subject do
        put "/api/admin/users/#{brand_user.id + 1}",
        headers: { Authorization: get_auth_token(user) },
        params:
      end

      it "returns not found error for user" do
        subject
        expect(json['errors']['user']).to eq(['not found'])
      end      
    end

    context "When status is invalid" do
      let!(:params) do
        {
          status: "gibberish"
        }
      end

      it "returns invalid status error" do
        subject
        expect(json['errors']['status']).to eq(['is invalid'])
      end
    end

    context "When params are valid" do
      let!(:params) do
        {
          status: "activate"
        }
      end
      
      it "sets the user's status correctly" do
        subject
        expect(brand_user.reload.status).to eq('active')
        expect(json['status']).to eq('active')
      end      
    end
  end
end
