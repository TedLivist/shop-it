module Api
  module Brand
    class ProductPolicy < ApplicationPolicy
      def create?
        user.brand?
      end
    end
  end
end
