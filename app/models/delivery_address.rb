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
class DeliveryAddress < ApplicationRecord
  belongs_to :customer

  def full_name
    [first_name, last_name].compact_blank.join(' ')
  end
end
