require 'rails_helper'

RSpec.describe Api::User::AuthController, type: :request do
  describe 'Verify Signup OTP' do
    let!(:user) { create(:user, :customer, otp: '123456', generated_at: Time.now.utc) }
    let!(:params) do
      {
        user: {
          otp: user.otp,
          email: user.email
        }
      }
    end

    subject do
      post '/api/user/verify_otp', params:
    end

    it 'returns a new auth token' do
      subject
      expect(json['token'].present?).to be(true)
    end
  end
end
