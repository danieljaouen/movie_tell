require 'rails_helper'

RSpec.describe Recommendation, :type => :model do
  let(:user1) { FactoryGirl.create(:user1) }
  let(:user2) { FactoryGirl.create(:user2) }

  describe 'valid scenarios' do
    before do
      @recommendation = Recommendation.new(rottentomatoes_id: 9559,
                                           recommender: user2,
                                           recommendee: user1)
    end
    it 'should be valid' do
      expect(@recommendation).to be_valid
    end
  end

  describe 'invalid scenarios' do
    describe 'invalid scenario without rottentomatoes_id' do
      subject do
        Recommendation.new(recommender: user2,
                           recommendee: user1)
      end
      it { should_not be_valid }
    end

    describe 'invalid scenario without recommender' do
      subject do
        Recommendation.new(rottentomatoes_id: 9559,
                           recommendee: user1)
      end
      it { should_not be_valid }
    end

    describe 'invalid scenario without recommendee' do
      subject do
        Recommendation.new(rottentomatoes_id: 9559,
                           recommender: user2)
      end
      it { should_not be_valid }
    end
  end

  describe 'foreign key scenarios' do
    let!(:recommendation) do
      recommendation = Recommendation.new(rottentomatoes_id: 9559,
                                          recommender: user2,
                                          recommendee: user1)
      recommendation.save

      recommendation
    end

    describe 'user2 recommendations includes @recommendation' do
      it 'should contain @recommendation in user1.recommendations' do
        expect(user2.recommendations).to include(recommendation)
      end
      it 'should contain @recommendation in user2.recommended' do
        expect(user1.recommended).to include(recommendation)
      end
    end
  end
end
