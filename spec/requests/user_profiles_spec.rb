require 'rails_helper'

RSpec.describe "UserProfiles", :type => :request do
  let!(:user1) { FactoryGirl.create(:user1) }

  describe 'GET /users/:id/profile' do
    before do
      visit '/users/sign_in'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'
    end

    it 'should create the user profile' do
      expect(UserProfile.all.length).to eq(0)
      visit '/users/1/profile'
      fill_in 'Your name', with: 'User 1'
      check 'Make profile private'
      click_on 'Update'
      expect(UserProfile.where(user: user1, private: true, show_ratings: false).length).to eq(1)

      uncheck 'Make profile private'
      click_on 'Update'
      expect(UserProfile.where(user: user1, private: false, show_ratings: false).length).to eq(1)
    end
  end
end
