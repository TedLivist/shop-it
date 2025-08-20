# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  delivery_address        :text
#  delivery_phone_number   :string
#  delivery_recipient_name :string
#  status                  :string
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
FactoryBot.define do
  factory :order do
    total_price { 9.99 }
    status { 'pending' }
    delivery_address { Faker::Lorem.sentence }
    delivery_phone_number { Faker::PhoneNumber.phone_number }
    delivery_recipient_name { Faker::Name.first_name + ' ' + Faker::Name.last_name }
    customer
  end
end
