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
FactoryBot.define do
  factory :delivery_address do
    phone_number { 'MyString' }
    description { 'MyText' }
    first_name { 'MyString' }
    last_name { 'MyString' }
    is_default { false }
    customer { nil }
  end
end
