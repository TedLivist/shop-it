module Products
  class Create < Base
    string :name, :description, :status
    float :price
    integer :stock, :category_id, :brand_id
    file :image

    validate :validate_category_exists

    def execute
      Product.transaction do
        @product = Product.new(product_params)

        save_or_rollback(@product)
      end
    end
  end
end
