module Api
  module Brand
    class OrderItemsPolicy < ApplicationPolicy
      
      def index?
        user.brand?
      end

    end
  end
end