# == Schema Information
#
# Table name: delivery_addresses
#
#  id           :bigint           not null, primary key
#  description  :text
#  first_name   :string
#  is_default   :boolean
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  customer_id  :bigint           not null
#
# Indexes
#
#  index_delivery_addresses_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
require 'rails_helper'

RSpec.describe DeliveryAddress, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
