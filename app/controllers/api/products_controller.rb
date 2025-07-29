module Api
  class ProductsController < ApiController
    skip_before_action :authenticate_user!, only: [:index]

    api :GET, '/api/products', 'Get all products'
    param :name, String, 'Product name', required: false
    param :category_name, String, 'Category name', required: false
    param :brand_name, String, 'Brand name', required: false

    def index
      products = Api::ProductsQuery.call(params)
      respond_with products
    end
  end
end
