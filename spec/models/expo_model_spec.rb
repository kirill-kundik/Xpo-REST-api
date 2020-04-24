require 'rails_helper'

RSpec.describe ExpoModel, type: :model do
  describe 'Associations' do
    it { should belong_to(:expo) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:ar_model_url) }
    it { should validate_presence_of(:marker_url) }
  end
end
