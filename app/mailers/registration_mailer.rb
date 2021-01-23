class RegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.welcome.subject
  #
  def welcome(online)
    @online = online

    mail(
    	subject: "ようこそ",
    	to: online.email
    	)
  end
end
