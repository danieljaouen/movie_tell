require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  let!(:user1) { FactoryGirl.create(:user1) }
  let!(:user2) { FactoryGirl.create(:user2) }

  describe 'GET /movies/search' do
    before do
      Friendship.create(user: user1, friend: user2, pending: false)
      Friendship.create(user: user2, friend: user1, pending: false)

      visit '/users/sign_in'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 's3kr3ttt'
      click_on 'Sign in'
    end

    it 'should have an Inception selection' do
      visit '/movies/search'
      fill_in 'title', with: 'inception'
      click_on 'Submit'

      expect(page).to have_content 'Inception'
    end

    it 'should have no rating at first' do
      expect(Movie.all.length).to eq(0)
      expect(Rating.all.length).to eq(0)

      visit '/movies/search'
      fill_in 'title', with: 'inception'
      click_on 'Submit'

      click_on 'Inception'
      choose '10'
      click_on 'Create Rating'

      expect(Movie.all.length).to eq(1)
      expect(Rating.where(rater: user1, rating: 10).length).to eq(1)
    end

    it 'should have no recommendation at first' do
      expect(Movie.all.length).to eq(0)
      visit '/movies/search'
      fill_in 'title', with: 'Inception'
      click_on 'Submit'
      click_on 'Inception'
      check 'user2@example.com'
      click_on 'Submit'
      expect(Movie.all.length).to eq(1)
      expect(Recommendation.where(recommender: user1).length).to eq(1)

      visit '/'
      click_on 'Delete'
      expect(Recommendation.all.length).to eq(0)
    end
  end
end
