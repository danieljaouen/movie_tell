require 'rails_helper'

RSpec.describe Rating, :type => :model do
  describe 'valid scenarios' do
    subject { Rating.new(rottentomatoes_id: 9559, rater: FactoryGirl.create(:user1), rating: 10) }
    it { should be_valid }
  end

  describe 'invalid scenarios' do
    describe 'invalid scenario without rottentomatoes_id' do
      subject { Rating.new(rater: FactoryGirl.create(:user1), rating: 10) }
      it { should_not be_valid }
    end

    describe 'invalid scenario without rater' do
      subject { Rating.new(rottentomatoes_id: 9559, rating: 10) }
      it { should_not be_valid }
    end

    describe 'invalid scenario without rating' do
      subject { Rating.new(rottentomatoes_id: 9559, rater: FactoryGirl.create(:user1)) }
      it { should_not be_valid }
    end

    describe 'invalid scenario with rating too low' do
      subject { Rating.new(rottentomatoes_id: 9559, rater: FactoryGirl.create(:user1), rating: -1) }
      it { should_not be_valid }
    end

    describe 'invalid scenario with rating too high' do
      subject { Rating.new(rottentomatoes_id: 9559, rater: FactoryGirl.create(:user1), rating: 11) }
      it { should_not be_valid }
    end
  end
end
