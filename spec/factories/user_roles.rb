# == Schema Information
#
# Table name: user_roles
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :user_role do
    name { "MyString" }
    description { "MyString" }
  end
end
