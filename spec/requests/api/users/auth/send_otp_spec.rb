require 'rails_helper'

RSpec.describe Api::User::AuthController, type: :request do
  describe 'Send OTP' do
    let!(:user) { create(:user) }
    let!(:params) do
      {
        email: user.email
      }
    end

    subject do
      post '/api/user/send_otp', params:
    end

    context 'When OTP is not set' do
      it 'returns false' do
        expect(user.otp).to be(nil)
      end
    end

    context 'When OTP is set' do
      it 'returns true' do
        subject
        expect(user.reload.otp).to_not be(nil)
      end

      it 'confirms that an email was sent' do
        subject
        mails_delivered = ActionMailer::Base.deliveries
        mail = mails_delivered.first
        expect(mails_delivered.count).to eq(1)
        expect(mail.subject).to eq(I18n.t('user.mailer.send_otp.subject'))
        expect(mail.to).to eq([user.email])
      end
    end
  end
end
