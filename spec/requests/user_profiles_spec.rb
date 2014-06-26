require 'rails_helper'

RSpec.describe "UserProfiles", :type => :request do
  let!(:user1) { FactoryGirl.create(:user1) }
  let!(:user2) { FactoryGirl.create(:user2) }
  let!(:user3) { FactoryGirl.create(:user3) }

  describe 'GET /users/:id/profile' do
    before do
      # log in as user1
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

      visit '/users/1'
      expect(page).to have_content('Ratings')
      click_on 'Sign Out'

      visit '/users/sign_in'
      fill_in 'Email', with: 'user2@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'

      visit '/users/1'
      expect(page).to have_content('Private')

      visit '/users/3'
      expect(page).to have_content('user3@example.com')

      click_on 'Search Movies'
      fill_in 'title', with: 'inception'
      click_on 'Submit'
      click_on 'Inception'
      choose '10'
      click_on 'Create Rating'

      click_on 'Profile'
      fill_in 'Your name', with: 'User 2'
      check 'Show ratings in your profile'
      click_on 'Update'
      click_on 'Sign Out'

      visit '/users/sign_in'
      fill_in 'Email', with: 'user3@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'

      visit '/users/2'
      expect(page).to have_content('Ratings')
    end
  end
end
