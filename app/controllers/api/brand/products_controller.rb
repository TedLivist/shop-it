module Api
  module Brand
    class ProductsController < ApiController

      def create
        @products = Product.all
        authorize @products, policy_class: Brand::ProductPolicy
      end
    end
  end
end