require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome_email' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user: user).welcome_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to your Xpo.')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ENV['GMAIL_USER']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("<h2>Welcome, #{user.name}!</h2>")
    end
  end
end