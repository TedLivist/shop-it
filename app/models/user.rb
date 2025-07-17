# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_role_id           :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_role

  validates :first_name, :last_name, length: { minimum: 2, maximum: 24 }

  delegate :super_admin?, to: :user_role
  delegate :brand, to: :user_role
  delegate :customer?, to: :user_role

  def full_name
    [first_name, middle_name, last_name].compact_blank.join(' ')
  end
end
