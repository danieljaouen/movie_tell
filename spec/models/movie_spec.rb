require 'rails_helper'

RSpec.describe Movie, :type => :model do
  let(:user1) { FactoryGirl.create(:user1) }

  describe 'valid scenarios' do
    subject do
      Movie.new(rottentomatoes_id: 1,
                title: 'Test Title',
                year: '2014',
                mpaa_rating: 'R',
                critics_score: 100,
                audience_score: 100)
    end
    it { should be_valid }
  end

  describe 'invalid scenarios' do
    it 'should be invalid without rottentomatoes_id' do
      movie = Movie.new(title: 'Test Title',
                        year: '2014',
                        mpaa_rating: 'R',
                        critics_score: 100,
                        audience_score: 100)
      expect(movie).not_to be_valid
    end

    it 'should be invalid without year' do
      movie = Movie.new(rottentomatoes_id: 1,
                        title: 'Test Title',
                        mpaa_rating: 'R',
                        critics_score: 100,
                        audience_score: 100)
      expect(movie).not_to be_valid
    end

    it 'should be invalid without mpaa_rating' do
      movie = Movie.new(rottentomatoes_id: 1,
                        title: 'Test Title',
                        year: '2014',
                        critics_score: 100,
                        audience_score: 100)
      expect(movie).not_to be_valid
    end

    it 'should be invalid without year' do
      movie = Movie.new(rottentomatoes_id: 1,
                        title: 'Test Title',
                        mpaa_rating: 'R',
                        critics_score: 100,
                        audience_score: 100)
      expect(movie).not_to be_valid
    end

    it 'should be invalid without critics_score' do
      movie = Movie.new(rottentomatoes_id: 1,
                        title: 'Test Title',
                        year: '2014',
                        mpaa_rating: 'R',
                        audience_score: 100)
      expect(movie).not_to be_valid
    end

    it 'should be invalid without audience_score' do
      movie = Movie.new(rottentomatoes_id: 1,
                        title: 'Test Title',
                        year: '2014',
                        mpaa_rating: 'R',
                        critics_score: 100)
      expect(movie).not_to be_valid
    end

    it 'should be invalid with duplicate rottentomatoes_id' do
      Movie.create(rottentomatoes_id: 1,
                   title: 'Test Title',
                   year: '2014',
                   mpaa_rating: 'R',
                   audience_score: 100,
                   critics_score: 100)
      movie = Movie.new(rottentomatoes_id: 1,
                        title: 'Test Title',
                        year: '2014',
                        mpaa_rating: 'R',
                        audience_score: 100,
                        critics_score: 100)
      expect(movie).not_to be_valid
    end
  end
end
