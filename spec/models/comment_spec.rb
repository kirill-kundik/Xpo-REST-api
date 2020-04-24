require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:expo) }
  end

  describe 'Validations' do
    it do
      should validate_presence_of(:text)
      should_not allow_values(nil, '').for(:text)
    end
    it do
      should validate_presence_of(:likes_count)
      should_not allow_value(nil).for(:likes_count)
      should validate_numericality_of(:likes_count)
        .is_greater_than_or_equal_to(0)
    end
  end
end
