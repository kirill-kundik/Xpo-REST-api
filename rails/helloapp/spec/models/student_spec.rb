require 'rails_helper'

RSpec.describe Student, type: :model do
  subject { FactoryBot.build(:student) }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end

  context '#take_exam' do
    let(:course) { FactoryBot.create(:course) }

    it 'should return nil if student is not enrolled at that course' do
      expect(subject.take_exam(course)).to be_nil
    end

    it 'should return 61 if grade is greater than 0' do
      expect(subject.take_exam(course, 10)).to equal(61)
    end
  end
end
