class StatisticsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.statistics_mailer.statistics_email.subject
  #
  def statistics_email
    @email_details = params[:email_details]
    mail to: @email_details[:email], subject: 'Your Xpo statistics.'
  end
end
