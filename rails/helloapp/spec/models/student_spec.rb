require 'rails_helper'

RSpec.describe Student, type: :model do
  subject { FactoryBot.build(:student) }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end
end
