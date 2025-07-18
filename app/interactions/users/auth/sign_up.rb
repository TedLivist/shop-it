module Users
  module Auth
    class SignUp < Base
      string :email, :first_name, :last_name, :password, :password_confirmation, :user_role

      validate :validate_user_role

      def execute
        User.transaction do
          @user_role = UserRole.find_by(name: user_role)
          @user = User.new(email:, first_name:, last_name:, password:, password_confirmation:, user_role:)

          if @user_role.brand?
            save_or_rollback(@user)

            BrandMailer.send_pending_approval(user.email, user.first_name).deliver_now
            ::Brand.create(user: @user) # create associated brand record
          elsif @user_role.customer?
            @otp = generate_otp
            user.otp = @otp
            user.generated_at = Time.now.utc

            save_or_rollback(@user)

            CustomerMailer.send_otp(user.email, user.first_name, user.otp).deliver_now
            ::Customer.create(user: @user) # create associated customer record
          else
            errors.merge!(@user.errors)
          end
        end
      end

      def to_model
        { message: 'account created' }
      end

      private

      def save_or_rollback(record)
        unless record.save
          errors.merge!(record.errors)
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end
