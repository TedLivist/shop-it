FactoryBot.define do
  factory :product do
    name { "MyText" }
    description { "MyText" }
    price { "9.99" }
    stock { 1 }
    status { 1 }
    image_url { "MyString" }
    brand { nil }
  end
end
