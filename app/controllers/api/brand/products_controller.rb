module Api
  module Brand
    class ProductsController < ApiController

      def create
        products = Product.all
        p products
      end
    end
  end
end