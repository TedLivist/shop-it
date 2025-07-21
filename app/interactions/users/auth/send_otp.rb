module Users
  module Auth
    class SendOtp < Base
      string :email

      validate do
        @user = User.find_by(email:)
        errors.add(:email, :invalid) if @user.nil?
      end

      def execute
        User.transaction do
          otp = generate_otp
          user.update(otp:, generated_at: Time.now.utc)
          UserMailer.send_otp(otp, user.email, user.first_name).deliver_now
        end
      end

      def to_model
        { message: :sent }
      end
    end
  end
end
