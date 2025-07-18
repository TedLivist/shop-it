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
    end
  end
end
