class SendWelcomeEmailWorker
  include Sidekiq::Worker

  def perform(id)
    user = User.find id
    UserMailer.with(user: user).welcome_email.deliver_now
  end
end
