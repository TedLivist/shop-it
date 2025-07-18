class ApplicationInteraction < ActiveInteraction::Base
  # attr_reader :merchant, :user

  include ActionView::Helpers::TranslationHelper
  set_callback :execute, :after, :save_object_errors, if: :object_invalid?

  def valid?(*)
    return @_interaction_valid if instance_variable_defined?(:@_interaction_valid)
    return @_interaction_valid = false if errors.any?

    super
  end

  def invalid?
    !valid?
  end

  def to_model
    respond_to?(:object) ? object : {}
  end

  # def valid_url?(url)
  #   uri = URI.parse(url)
  #   return false unless [URI::HTTP, URI::HTTPS].include?(uri.class)
  #   return false unless uri.host&.match?(/\.[a-z]{2,}$/i)

  #   true
  # end

  private

  def object_invalid?
    respond_to?(:object) && object&.invalid?
  end

  def save_object_errors
    errors.merge!(object.errors)
  end
end
