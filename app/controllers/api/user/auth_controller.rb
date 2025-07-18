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
    end
  end
end
