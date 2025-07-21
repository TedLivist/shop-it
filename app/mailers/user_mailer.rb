class UserMailer < ApplicationMailer
  def send_otp(otp, email, first_name)
    @otp = otp
    @email = email
    @first_name = first_name

    mail(to: @email, subject: I18n.t('user.mailer.send_otp.subject'))
  end
end
