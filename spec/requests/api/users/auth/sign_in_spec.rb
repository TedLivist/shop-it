require 'rails_helper'

RSpec.describe Api::User::AuthController, type: :request do
  describe 'post #Signin' do
    context 'When user provided correct details' do
      let!(:user) { create(:user, password: '12345e45', password_confirmation: '12345e45', status: 'active') }
      let!(:params) do
        {
          user: {
            email: user.email,
            password: '12345e45'
          }
        }
      end

      subject do
        post '/api/user/sign_in', params:
      end

      it 'Signs user in succesfully' do
        subject
        expect(response).to have_http_status(:success)
        expect(json['email']).to eq(user.email)
        expect(json['token']).to_not be nil
      end
    end

    context 'When user status has not be activated' do
      let!(:user) { create(:user, password: '12345e45', password_confirmation: '12345e45') }
      let!(:params) do
        {
          user: {
            email: user.email,
            password: '12345e45'
          }
        }
      end

      subject do
        post '/api/user/sign_in', params:
      end

      it 'returns error message of inactive user' do
        subject
        expect(json['errors']['user']).to eq([I18n.t('active_interaction.errors.models.users/auth/sign_in.attributes.user.inactive',
                                                     attribute: 'User')])
      end
    end

    context 'When email is sent' do
      let!(:user) { create(:user) }
      let!(:params) do
        {
          user: {
            email: 'fanta.diallo@cc.com',
            password: '12345e45'
          }
        }
      end

      subject do
        post '/api/user/sign_in', params:
      end

      it 'returns email invalid error message' do
        subject
        expect(json['errors']['email']).to eq(['is invalid'])
      end
    end

    context 'When user is invalid' do
      let!(:user) { create(:user, password: '12345e45', password_confirmation: '12345e45') }
      let!(:params) do
        {
          user: {
            email: user.email,
            password: '12345e5'
          }
        }
      end

      subject do
        post '/api/user/sign_in', params:
      end

      it 'returns invalid password error message' do
        subject
        expect(json['errors']['password']).to eq(['is invalid'])
      end
    end
  end
end
