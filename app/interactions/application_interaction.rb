class ApplicationInteraction < ActiveInteraction::Base
  attr_reader :user

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

  def generate_otp
    6.times.map { rand(9) }.join
  end

  def otp_valid?(otp, user)
    return false if otp.nil?

    expiration_time = 5 # 5 minutes

    # Time difference in seconds
    # Convert to minutes
    # Round up to nearest integer
    elapsed_time = ((Time.now.utc - user.generated_at) / 1.minute).round

    # otp is valid if elapsed time (minutes) is less than expiration (minutes) and
    # the provided otp is equal to the user's otp value
    (elapsed_time < expiration_time) && (otp == user.otp)
  end

  def save_or_rollback(record)
    unless record.save
      errors.merge!(record.errors)
      raise ActiveRecord::Rollback
    end
  end

  private

  def object_invalid?
    respond_to?(:object) && object&.invalid?
  end

  def save_object_errors
    errors.merge!(object.errors)
  end
end
