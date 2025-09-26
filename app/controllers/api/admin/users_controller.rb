module Api
  module Admin
    class UsersController < ApiController
      api :GET, '/api/admin/users/filtered', 'Get list of filtered users'
      header :Authorization, 'Auth token', required: true
      param :status, ::User.aasm.states.map(&:name) - [:active], 'User status', required: false
      param :user_role, (UserRole::NAMES - [:super_admin]).map(&:to_s), 'User role', required: true

      def filtered
        authorize @current_user, policy_class: Admin::UsersPolicy
        unless params[:status].in?(%w[pending inactive]) && params[:user_role].in?(%w[customer brand])
          render json: { error: 'Valid status and role parameters are required' }, status: :bad_request
          return
        end

        users = Api::Admin::UsersQuery.call(params)
        respond_with users
      end
    end
  end
end
