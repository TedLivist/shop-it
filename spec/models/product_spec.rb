# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image_url   :string
#  name        :text
#  price       :decimal(, )
#  status      :integer
#  stock       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  brand_id    :bigint           not null
#
# Indexes
#
#  index_products_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
