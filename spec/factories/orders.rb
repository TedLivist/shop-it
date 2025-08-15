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
    total_price { '9.99' }
    status { 1 }
    delivery_address { 'MyText' }
    delivery_phone_number { 'MyString' }
    delivery_recipient_name { 'MyString' }
    customer { nil }
  end
end
