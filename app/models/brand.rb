# == Schema Information
#
# Table name: brands
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_brands_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Brand < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :order_items, through: :products

  def top_products_by_quantity(limit = 5)
    products.joins(:order_items)
            .group('products.id')
            .order('SUM(order_items.quantity) DESC')
            .limit(limit)
  end

  def total_sales
    order_items.sum('order_items.quantity * order_items.unit_price')
  end
end
