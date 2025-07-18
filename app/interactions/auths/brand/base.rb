module Auths
  module Brand
    class Base < ApplicationInteraction
      attr_reader :user

      def to_model
        user.reload
      end      
    end
  end
end