module Api
  class CategoriesController < ApiController
    skip_before_action :authenticate_user!

    def index
      categories = Category.order(:id)
      respond_with categories, each_serializer: Api::CategoriesSerializer
    end
  end
end
