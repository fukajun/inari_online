class RegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.welcome.subject
  #
  def welcome(online)
    @online = online

    mail(
    	subject: "【稲荷塾】 登録完了のお知らせ",
    	to: online.email
    	)
  end
  def welcome_parent(online)
    @online = online

    mail(
    	subject: "【稲荷塾】 登録完了・受講料振込のご案内",
    	to: online.parent_email
    	)
  end
end
