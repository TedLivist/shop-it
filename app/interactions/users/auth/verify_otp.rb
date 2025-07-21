module Users
  module Auth
    class VerifyOtp < Base
      string :otp, :email

      validate do
        @user = User.find_by(email:)

        if user.nil?
          errors.add(:user, :not_found)
        elsif @user.otp.nil?
          errors.add(:otp, :invalid)
        elsif !otp_valid?(otp, user)
          errors.add(:otp, :invalid)
        end
      end

      def execute
        User.transaction do
          user.update(
            otp: nil,
            generated_at: nil
          )

          user.approve! if user.customer? && user.may_approve?
        end
      end
    end
  end
end
