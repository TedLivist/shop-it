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
class User < ApplicationRecord
  include AASM

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_role
  has_many :customers
  has_one :brand

  validates :first_name, :last_name, length: { minimum: 2, maximum: 24 }

  delegate :super_admin?, to: :user_role
  delegate :brand?, to: :user_role
  delegate :customer?, to: :user_role

  def full_name
    [first_name, middle_name, last_name].compact_blank.join(' ')
  end

  aasm column: :status do
    state :pending, initial: true
    state :approved
    state :declined

    event :approve do
      transitions from: [:pending, :declined], to: :approved
    end

    event :decline do
      transitions from: :pending, to: :declined
    end

    event :pend do
      transitions from: :declined, to: :pending
    end
  end
end
