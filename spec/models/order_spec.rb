# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  delivery_address        :text
#  delivery_phone_number   :string
#  delivery_recipient_name :string
#  status                  :integer
#  total_price             :decimal(, )
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  customer_id             :bigint           not null
#
# Indexes
#
#  index_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
