require 'rails_helper'

RSpec.describe Api::User::AuthController, type: :request do
  describe '/api/user/sign_up' do
    let!(:user_role) { create(:user_role, name: :brand) }
    let!(:user_role2) { create(:user_role, name: :customer) }

    context 'When valid brand parameters are provided' do
      let!(:params) do
        {
          user: {
            email: Faker::Internet.email,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            password: '12345678',
            password_confirmation: '12345678',
            user_role: 'brand'
          }
        }
      end

      subject do
        post '/api/user/sign_up', params:
      end

      it 'Signs up brand user successfully' do
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

      it 'sends pending approval mail' do
        subject
        user = User.first

        mails_delivered = ActionMailer::Base.deliveries
        mail = mails_delivered.first
        expect(mails_delivered.count).to eq(1)
        expect(mail.subject).to eq(I18n.t('brand.mailer.send_pending_approval.subject'))
        expect(mail.to).to eq([user.email])
      end
    end

    context 'When valid customer parameters are provided' do
      let!(:params) do
        {
          user: {
            email: Faker::Internet.email,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            password: '12345678',
            password_confirmation: '12345678',
            user_role: 'customer'
          }
        }
      end

      subject do
        post '/api/user/sign_up', params:
      end

      it 'Signs up customer user successfully' do
        subject
        expect(response).to have_http_status(:success)
        expect(json['message']).to eq('account created')
      end

      it 'creates the user' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'creates a customer record' do
        expect { subject }.to change(Customer, :count).by(1)
      end

      it 'create user as a customer' do
        subject
        user = User.first
        expect(user.customer?).to be(true)
      end

      it 'sets and sends user otp to mail' do
        subject
        user = User.first
        expect(user.otp).to_not be(nil)
        expect(user.generated_at).to_not be(nil)

        mails_delivered = ActionMailer::Base.deliveries
        mail = mails_delivered.first
        expect(mails_delivered.count).to eq(1)
        expect(mail.subject).to eq(I18n.t('user.mailer.send_otp.subject'))
        expect(mail.to).to eq([user.email])
      end
    end

    context 'When invalid user role is provided' do
      let!(:params) do
        {
          user: {
            email: Faker::Internet.email,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            password: '12345678',
            password_confirmation: '12345678',
            user_role: 'super_admin'
          }
        }
      end

      subject do
        post '/api/user/sign_up', params:
      end

      it 'Signs up customer user successfully' do
        subject
        expect(json['errors']['user_role']).to eq(['is invalid'])
      end
    end
  end
end
