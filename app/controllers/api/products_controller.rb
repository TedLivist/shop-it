module Api
  class ProductsController < ApiController
    skip_before_action :authenticate_user!

    api :GET, '/api/products', 'Get all products'
    param :name, String, 'Product name', required: false
    param :category_name, String, 'Category name', required: false
    param :brand_name, String, 'Brand name', required: false

    def index
      products = Api::ProductsQuery.call(params)
      respond_with products
    end

    api :GET, '/api/products/:id', 'Get a product'
    param :id, Integer, 'Product ID', required: true

    def show
      product = Product.find(params[:id])
      respond_with product
    end
  end
end
