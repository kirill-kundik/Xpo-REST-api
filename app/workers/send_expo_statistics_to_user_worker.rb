require 'sidekiq-scheduler'

class SendExpoStatisticsToUserWorker
  include Sidekiq::Worker

  def perform
    yesterday = Date.yesterday
    User.find_each do |user|
      next if user.expos.empty?

      email_details = {
        user_name: user.name,
        email: user.email,
        expos: user.expos.map { |expo| expo.statistics(yesterday) }.compact
      }
      StatisticsMailer.with(email_details: email_details)
                      .statistics_email.deliver_now
    end
  end
end
