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
class Order < ApplicationRecord
  include AASM

  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items

  accepts_nested_attributes_for :order_items

  aasm column: :status do
    state :pending, initial: true
    state :processing
    state :partly_shipped
    state :shipped
    state :partly_delivered
    state :delivered
    state :cancelled

    event :process do
      transitions from: :pending, to: :processing
    end

    event :partly_ship do
      transitions from: :processing, to: :partly_shipped
    end

    event :ship do
      transitions from: [:processing, :partly_shipped], to: :shipped
    end

    event :partly_deliver do
      transitions from: [:partly_shipped, :shipped], to: :partly_delivered
    end

    event :deliver do
      transitions from: [:shipped, :partly_delivered], to: :delivered
    end

    event :cancel do
      transitions from: [:pending, :processing, :shipped], to: :cancelled
    end
  end
end
