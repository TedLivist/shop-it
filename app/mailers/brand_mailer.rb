class BrandMailer < ApplicationMailer
  def send_pending_approval(email, first_name)
    @email = email
    @first_name = first_name

    mail(to: @email, subject: I18n.t('brand.mailer.send_pending_approval.subject'))
  end
end
