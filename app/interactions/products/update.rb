module Products
  class Update < Base
    object :product, class: Product

    string :name, :description, :status, default: nil
    float :price, default: nil
    integer :stock, default: nil
    file :image, default: nil

    def execute
      Product.transaction do
        product.update(product_params)
      end
    end
  end
end
