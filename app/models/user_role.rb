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
class UserRole < ApplicationRecord
  has_many :users, dependent: :nullify

  NAMES = [:super_admin, :brand, :customer].freeze

  validates :name, presence: true, inclusion: { in: NAMES.map(&:to_s) }

  NAMES.each do |name|
    define_method "#{name}?" do
      return false if self.name.nil?

      self.name.to_sym == name
    end
  end
end
