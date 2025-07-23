module Api
  module User
    class AuthController < ApiController
      skip_before_action :authenticate_user!

      api :POST, '/api/user/sign_up', 'Sign up a new customer'
      param :user, Hash do
        param :first_name, String, 'User first name', required: true
        param :last_name, String, 'User last name', required: true
        param :email, String, 'User email', required: true
        param :password, String, 'Password', required: true
        param :password_confirmation, String, 'Password confirmation', required: true
        param :user_role, (UserRole::NAMES - [:super_admin]).map(&:to_s), 'User role', required: true
      end

      def sign_up
        payload = params.fetch(:user, {})
        result = Users::Auth::SignUp.run(payload)
        respond_with result
      end

      api :POST, '/api/user/verify_otp', 'Verify OTP'
      param :user, Hash do
        param :otp, String, 'OTP', required: true
        param :email, String, 'User email', required: true
      end

      def verify_otp
        payload = params.require(:user).permit(:otp, :email)
        result = Users::Auth::VerifyOtp.run(payload)
        respond_with result, serializer: Api::User::AuthSerializer
      end

      api :POST, '/api/user/send_otp', 'Send OTP'
      param :email, String, 'User email', required: true

      def send_otp
        payload = params.permit(:email)
        result = Users::Auth::SendOtp.run(payload)
        respond_with result
      end

      api :POST, '/api/user/sign_in', 'Sign in a user'
      param :user, Hash do
        param :email, String, 'User email', required: true
        param :password, String, 'User password', required: true
      end

      def sign_in
        payload = params.fetch(:user, {})
        result = ::Users::Auth::SignIn.run(payload)
        respond_with result, serializer: Api::User::AuthSerializer
      end
    end
  end
end
