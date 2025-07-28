module Api
  class ProductSerializer < ApplicationSerializer
    attributes :id, :description, :image_url, :name, :price, :status, :stock, :brand, :category

    def brand
      return unless object.brand

      {
        id: object.brand.id,
        name: object.brand.name
      }
    end

    def category
      return unless object.category

      {
        id: object.category.id,
        name: object.category.name
      }
    end
  end
end
