require 'rails_helper'

RSpec.describe UserProfile, :type => :model do
  describe 'valid scenarios' do
    subject { FactoryGirl.create(:user_profile) }
    it { should be_valid }
  end
end
