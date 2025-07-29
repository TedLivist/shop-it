module Api
  class ProductsQuery < ApplicationQuery
    def call
      name = options[:name]
      brand_name = options[:brand_name]
      category_name = options[:category_name]

      scope = Product.order(created_at: :desc)
      scope = scope.where('name ILIKE ?', "%#{name}%") if name.present?
      scope = scope.joins(:brand).where('brands.name ILIKE ?', "%#{brand_name}%") if brand_name.present?
      scope = scope.joins(:category).where('categories.name ILIKE ?', "%#{category_name}%") if category_name.present?

      scope.where(status: 'published') # only return products that are published
    end
  end
end
