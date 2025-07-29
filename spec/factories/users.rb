# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  generated_at           :datetime
#  last_name              :string
#  otp                    :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_role_id           :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { '12345678' }
    password_confirmation { '12345678' }
    status { 'active' }
    user_role

    trait :with_role do
      association :user_role, factory: :user_role
    end

    trait :customer do
      with_role
      after(:create) do |user|
        create(:customer, user: user)
      end
    end

    trait :brand do
      association :user_role, factory: :user_role, name: 'brand'
      after(:create) do |user|
        create(:brand, user: user)
      end
    end
  end
end
