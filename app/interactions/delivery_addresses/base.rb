module DeliveryAddresses
  class Base < ApplicationInteraction
    attr_reader :delivery_address

    def to_model
      delivery_address.reload
    end

    def validate_default_value
      unless inputs[:is_default].nil?
        if inputs[:is_default] == false
          errors.add(:is_default, :must_be_true)
          throw(:abort)
        elsif inputs[:is_default] == true
          query = customer.delivery_addresses.where(is_default: true)
          query = query.where.not(id: delivery_address.id) if delivery_address&.id.present?
          query.update_all(is_default: false)
        end
      end
    end

    private

    def delivery_address_params
      data = inputs.slice(:phone_number, :description, :first_name, :last_name, :is_default)

      data[:phone_number] = delivery_address.phone_number unless inputs[:phone_number].present?
      data[:description] = delivery_address.description unless inputs[:description].present?
      data[:first_name] = delivery_address.first_name unless inputs[:first_name].present?
      data[:last_name] = delivery_address.last_name unless inputs[:last_name].present?

      data[:is_default] = delivery_address&.is_default || false if inputs[:is_default].nil?

      data
    end
  end
end
