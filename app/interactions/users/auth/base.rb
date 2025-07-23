module Users
  module Auth
    class Base < ApplicationInteraction
      attr_reader :user

      def to_model
        user.reload
      end

      def validate_user_role
        role = UserRole.find_by(name: @user_role)
        if role.nil? || role.super_admin?
          errors.add(:user_role, :invalid)
          throw(:abort)
        end
      end

      def validate_user
        @user = User.find_by(email:)
        if @user.nil?
          errors.add(:email, :invalid)
          throw(:abort)
        end
      end

      def validate_password
        unless @user.valid_password?(password)
          errors.add(:password, :invalid)
          throw(:abort)
        end
      end

      def validate_active_user
        if @user.pending? || @user.inactive?
          errors.add(:user, :inactive)
          throw(:abort)
        end
      end
    end
  end
end
