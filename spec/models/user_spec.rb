# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do

  describe 'Associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:user_expos).dependent(:destroy) }
    it { should have_many(:expos).dependent(:destroy) }
    it do
      should have_many(:visited_expo).join_table(:user_expos)
                                     .class_name('Expo')
                                     .through(:user_expos)
                                     .source(:expo)
                                     .conditions(
                                       'user_expos.is_organizer = false'
                                     )
    end
  end

  describe 'Validations' do
    it { should validate_presence_of(:login) }
    it { should validate_presence_of(:name) }

    subject { build(:user) }

    it { should validate_uniqueness_of(:login) }
  end

  describe 'Abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { create(:user) }
    let(:user_comment) { create(:comment, user: user) }
    let(:not_user_comment) { create(:comment) }

    context 'regular user' do
      it { is_expected.to be_able_to(:read, Expo.new) }

      it { is_expected.to be_able_to(:read, ExpoModel.new) }

      it { is_expected.to be_able_to(:create, Comment.new) }
      it { is_expected.to be_able_to(:read, Comment.new) }
      it { is_expected.to be_able_to(:update, user_comment) }
      it { is_expected.not_to be_able_to(:update, not_user_comment) }
      it { is_expected.to be_able_to(:destroy, user_comment) }
      it { is_expected.not_to be_able_to(:destroy, not_user_comment) }

      it { is_expected.to be_able_to(:read, User.new) }
      it { is_expected.to be_able_to(:update, user) }
      it { is_expected.not_to be_able_to(:update, create(:user)) }
      it { is_expected.to be_able_to(:destroy, user) }
      it { is_expected.not_to be_able_to(:destroy, create(:user)) }

      it { is_expected.to be_able_to(:create, UserExpo.new) }
      it { is_expected.not_to be_able_to(:read, UserExpo.new) }
      it { is_expected.to be_able_to(:update, UserExpo.new(user_id: user.id)) }
      it { is_expected.not_to be_able_to(:update, UserExpo.new(user_id: create(:user).id)) }
      it { is_expected.not_to be_able_to(:destroy, User.new) }

      it { is_expected.to be_able_to(:visit, :visits_like) }
      it { is_expected.to be_able_to(:like, :visits_like) }
    end

    context 'when is an organizer' do
      let(:user) { create(:organizer) }
      let(:user_expo) { create(:expo_wih_models, user: user) }
      let(:not_user_expo) { create(:expo_wih_models) }

      it { is_expected.to be_able_to(:create, Expo.new) }
      it { is_expected.to be_able_to(:update, user_expo) }
      it { is_expected.not_to be_able_to(:update, not_user_expo) }
      it { is_expected.to be_able_to(:destroy, user_expo) }
      it { is_expected.not_to be_able_to(:destroy, not_user_expo) }

      it { is_expected.to be_able_to(:create, ExpoModel.new) }
      it { is_expected.to be_able_to(:update, user_expo.expo_models.first) }
      it do
        is_expected.not_to be_able_to(:update, not_user_expo.expo_models.first)
      end
      it { is_expected.to be_able_to(:destroy, user_expo.expo_models.first) }
      it do
        is_expected.not_to be_able_to(:destroy, not_user_expo.expo_models.first)
      end
    end

    context 'when is a superuser' do
      let(:user) { create(:superadmin) }

      [User, Expo, ExpoModel, Comment, UserExpo].each do |model|
        %i[create read update destroy].each do |role|
          it { is_expected.to be_able_to(role, model.new) }
        end
      end
    end
  end
end
