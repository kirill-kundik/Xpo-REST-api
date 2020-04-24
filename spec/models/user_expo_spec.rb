require 'rails_helper'

RSpec.describe UserExpo, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:expo) }
  end

  describe 'perform visit and like' do
    let(:user) { create(:user) }
    let(:expo) { create(:expo) }
    let(:user_expo) { UserExpo.create({ user_id: user.id, expo_id: expo.id }) }

    it 'should increase expo visits by 1' do
      user_expo.perform_visit
      expect(Expo.find(expo.id).views_count).to eq(expo.views_count + 1)
    end
  end
end
