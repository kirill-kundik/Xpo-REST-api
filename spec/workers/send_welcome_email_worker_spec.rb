require 'rails_helper'
RSpec.describe SendWelcomeEmailWorker, type: :worker do
  let!(:user) { create(:user) }

  subject { SendWelcomeEmailWorker }

  it 'should send the email' do
    subject.perform_async user_id: user.id
    # literally no idea what to assert here...
    # assert
  end

  it 'should push job to the queue' do
    expect do
      subject.perform_async user_id: user.id
    end.to change(subject.jobs, :size).by(1)
  end
end
