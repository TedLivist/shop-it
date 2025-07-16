FactoryBot.define do
  factory :delivery_address do
    phone_number { "MyString" }
    description { "MyText" }
    first_name { "MyString" }
    last_name { "MyString" }
    is_default { false }
    customer { nil }
  end
end
