require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user1) { FactoryGirl.create(:user1) }
  let!(:user2) { FactoryGirl.create(:user2) }

  describe 'GET /' do
    before do
      visit '/users/sign_in'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'
    end

    it 'should have the content "Pending Friends"' do
      visit '/'
      expect(page).to have_content('Pending Friends')
    end
  end

  describe 'user friending' do
    it 'should behave correctly' do
      expect(Friendship.all.length).to eq(0)

      visit '/users/sign_in'
      fill_in 'Email', with: 'user2@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'

      visit '/users/search'
      fill_in 'email', with: 'user1@example.com'
      click_on 'Submit'
      click_on 'user1@example.com'
      click_on 'Friend'
      expect(Friendship.all.length).to eq(1)

      click_on 'Sign Out'
      visit '/users/sign_in'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'

      visit '/users/search'
      fill_in 'email', with: 'user2@example.com'
      click_on 'Submit'
      click_on 'user2@example.com'
      click_on 'Friend'
      expect(Friendship.all.length).to eq(2)

      click_on 'Unfriend'
      expect(Friendship.all.length).to eq(0)
    end
  end
end
