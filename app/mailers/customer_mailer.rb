class CustomerMailer < ApplicationMailer
  def send_otp(email, first_name, otp)
    @email = email
    @first_name = first_name
    @otp = otp

    mail(to: @email, subject: I18n.t('customer.mailer.send_otp.subject'))
  end
end
