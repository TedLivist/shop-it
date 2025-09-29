module Admin
  module Users
    class Update < Base
      string :status
      integer :id

      validate :validate_user, :validate_status

      def execute
        User.transaction do
          user.aasm.fire!(status.to_sym)
        end
      end
    end
  end
end
