module Auths
  module Brand
    class SignUp < Base
      string :email, :first_name, :last_name, :password, :password_confirmation

      def execute
        User.transaction do
          @user_role = UserRole.find_by(name: 'brand')
          @user = User.new(email:, first_name:, last_name:, password:, password_confirmation:, user_role: @user_role)

          if @user.save
            BrandMailer.send_pending_approval(user.email, user.first_name).deliver_now

            # create associated brand record
            ::Brand.create(user: @user)
          else
            errors.merge!(@user.errors)
          end
        end
      end

      def to_model
        { message: 'account created' }
      end
    end
  end
end
