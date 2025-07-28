module Products
  class Base < ApplicationInteraction
    attr_reader :product, :category

    def to_model
      product.reload
    end

    def validate_category_exists
      @category = Category.find_by(id: category_id)
      unless category
        errors.add(:category, :not_found)
        throw(:abort)
      end
    end

    private

    def product_params
      data = inputs.slice(:name, :description, :status, :price, :stock, :brand_id, :category_id)

      data[:image_url] = attach_image(inputs[:image])
      data
    end

    def attach_image(image)
      upload_return = Cloudinary::Uploader.upload(image)
      upload_return['url']
    end
  end
end
