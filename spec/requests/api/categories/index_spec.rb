require 'rails_helper'

RSpec.describe Api::CategoriesController, type: :request do
  describe 'GET /api/categories' do
    let!(:categories) { create_list(:category, 5) }

    subject do
      get '/api/categories'
    end

    context 'When request to fetch categories is made' do
      it 'returns all the categories' do
        subject
        expect(json.size).to eq(5)
      end
    end
  end
end
