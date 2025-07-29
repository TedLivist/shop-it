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

      data[:name] = product.name unless inputs[:name].present?
      data[:description] = product.description unless inputs[:description].present?
      data[:status] = product.status unless inputs[:status].present?
      data[:price] = product.price unless inputs[:price].present?
      data[:stock] = product.stock unless inputs[:stock].present?

      data[:image_url] = attach_image(inputs[:image]) if inputs[:image].present?

      data
    end

    def attach_image(image)
      upload_return = Cloudinary::Uploader.upload(image)
      upload_return['url']
    end
  end
end
