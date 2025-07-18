module Api
  module User
    class BrandAuthController < ApiController
      skip_before_action :authenticate_user!

      api :POST, '/api/user/brand_sign_up', 'Sign up a new brand user'
      param :user, Hash do
        param :first_name, String, 'User first name', required: true
        param :last_name, String, 'User last name', required: true
        param :email, String, 'User email', required: true
        param :password, String, 'Password', required: true
        param :password_confirmation, String, 'Password confirmation', required: true
      end

      def sign_up
        payload = params.fetch(:user, {})
        result = ::Auths::Brand::SignUp.run(payload)
        # puts result
        respond_with result
      end
    end
  end
end
