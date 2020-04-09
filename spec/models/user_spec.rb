# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(login: 'something', name: 'something else', password: '123456')
  end

  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:login) }
  it { should have_secure_password }
end
