require 'rails_helper'

RSpec.describe Expo, type: :model do
  describe 'Associations' do
    it { should have_many(:user_expos).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should have_many(:expo_models).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:location_name) }
    it { should validate_presence_of(:views_count) }
    it do
      should validate_numericality_of(:views_count)
               .is_greater_than_or_equal_to(0)
    end
    it { should_not allow_values(nil, '', 'abc').for(:start_time) }
    it { should_not allow_values(nil, '', 'abc').for(:end_time) }
    it do
      should allow_values('2020-04-10', '2020-101', '2020-W15').for(:start_time)
    end
    it do
      should allow_values('2020-04-10', '2020-101', '2020-W15').for(:end_time)
    end
  end

  describe 'statistics method validation' do
    let(:expo) { create(:expo) }
    let(:user) { create(:user) }
    let(:user_expo) { UserExpo.create({ user_id: user.id, expo_id: expo.id }) }

    it 'should return expo statistics for expo for the last day' do
      user_expo.perform_visit

      create(:comment, expo: expo, user: user)

      expect(Expo.find(expo.id)
                 .statistics(Date.yesterday)[:last_comments].size)
        .to eq(1)
      expect(Expo.find(expo.id)
                 .statistics(Date.yesterday)[:last_likes]).to eq(1)
      expect(Expo.find(expo.id)
                 .statistics(Date.yesterday)[:total_likes])
        .to eq(expo.likes_count)
      expect(Expo.find(expo.id)
                 .statistics(Date.yesterday)[:total_views])
        .to eq(expo.views_count + 1)
      expect(Expo.find(expo.id)
                 .statistics(Date.yesterday)[:last_comments].first[:user_login])
        .to eq(user.login)
    end
  end
end
