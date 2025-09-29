module Admin
  module Users
    class Base < ApplicationInteraction
      attr_reader :user

      def to_model
        user.reload
      end

      def validate_user
        @user = User.find_by(id:)
        unless @user
          errors.add(:user, :not_found)
          throw(:abort)
        end
      end

      def validate_status
        status_events = ::User.aasm.events.map(&:name)
        unless status_events.include?(status.to_sym)
          errors.add(:status, :invalid)
          throw(:abort)
        end
      end
    end
  end
end
