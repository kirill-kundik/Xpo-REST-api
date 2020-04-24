require 'rails_helper'

RSpec.describe StatisticsMailer, type: :mailer do
  describe 'statistics_email' do
    let(:user) { create(:organizer_with_expos) }
    let(:mail) do
      StatisticsMailer.with(
        email_details: {
          user_name: user.name,
          email: user.email,
          expos: user.expos.map { |expo| expo.statistics(Date.yesterday) }.compact
        }
      ).statistics_email
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Your Xpo statistics.')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ENV['GMAIL_USER']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to(
        match("<b>Expo Name</b>: #{user.expos.first.name}")
      )
    end
  end
end