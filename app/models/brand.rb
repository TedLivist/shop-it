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
end
