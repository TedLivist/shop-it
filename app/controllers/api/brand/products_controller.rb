module Api
  module Brand
    class ProductsController < ApiController
      api :POST, '/api/brand/products', 'Create new product'
      header :Authorization, 'Auth token', required: true
      param :product, Hash do
        param :name, String, 'Name of product', required: true
        param :description, String, 'Description of product', required: true
        param :price, Float, 'Price of product in naira', required: true
        param :stock, Integer, 'Stock of available products', required: true
        param :status, Product.statuses.keys, 'Product status', required: true
        param :image, File, 'Image of product', required: true
        param :category_id, Integer, 'Category ID', required: true
      end

      def create
        authorize @current_user, policy_class: Brand::ProductPolicy
        payload = params.fetch(:product, {}).merge(brand_id: @current_user.brand.id)
        result = Products::Create.run(payload)
        respond_with result, serializer: Api::ProductSerializer
      end

      api :POST, '/api/brand/products/:id', 'Update a product'
      header :Authorization, 'Auth token', required: true
      param :id, Integer, 'ID of product', required: true
      param :product, Hash do
        param :name, String, 'Name of product', required: false
        param :description, String, 'Description of product', required: false
        param :price, Float, 'Price of product in naira', required: false
        param :stock, Integer, 'Stock of available products', required: false
        param :status, Product.statuses.keys, 'Product status', required: false
        param :image, File, 'Image of product', required: false
      end

      def update
        product = Product.find(params[:id])
        authorize product, policy_class: Brand::ProductPolicy
        payload = params.fetch(:product, {}).merge(product:)
        result = Products::Update.run(payload)
        respond_with result, serializer: Api::ProductSerializer
      end

      api :DELETE, '/api/brand/products/:id', 'Delete a product'
      header :Authorization, 'Auth token', required: true
      param :id, Integer, 'ID of product', required: true

      def destroy
        product = Product.find(params[:id])
        authorize product, policy_class: Brand::ProductPolicy
        product.destroy!
        render json: { product: 'deleted' }
      end
    end
  end
end
