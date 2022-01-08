class RegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.welcome.subject
  #
  def welcome(online)
    @online = online

    mail(
      subject: "【稲荷塾オンライン講座】 新規登録を受け付けました",
      to: online.email
    )
  end

  def welcome_parent(online)
    @online = online

    mail(
      subject: "【稲荷塾オンライン講座】 受講料のお支払いについて",
      to: online.parent_email
    )
  end

  def course_application(online, payment)
    @online = online
    @payment = payment

    mail(
      subject: "【稲荷塾オンライン講座】 受講料のお支払いについて",
      to: online.parent_email
    )
  end
end
