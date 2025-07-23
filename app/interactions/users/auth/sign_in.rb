module Users
  module Auth
    class SignIn < Base
      string :email, :password

      validate :validate_user, :validate_password, :validate_active_user
      def execute; end
    end
  end
end
