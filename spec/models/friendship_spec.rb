require 'rails_helper'

RSpec.describe Friendship, :type => :model do
  describe 'valid scenarios' do
    before :each do
      @user1 = FactoryGirl.create(:user1)
      @user2 = FactoryGirl.create(:user2)

      @friendship1 = @user1.friendships.build(user: @user1, friend: @user2, pending: false)
      @friendship1.save

      @friendship2 = @user2.friendships.build(user: @user2, friend: @user1, pending: false)
      @friendship2.save
    end

    it 'should include the appropriate friends' do
      expect(@user1.friends).to include(@user2)
      expect(@user2.friends).to include(@user1)
    end

    it 'should not include self in friends' do
      expect(@user1.friends).not_to include(@user1)
      expect(@user2.friends).not_to include(@user2)
    end
  end

  describe 'pending scenarios' do
    # user2 "friends" user1
    before :each do
      @user1 = FactoryGirl.create(:user1)
      @user2 = FactoryGirl.create(:user2)

      @user1.friendships.create(user: @user1, friend: @user2, pending: true)
    end

    it 'should contain user2' do
      expect(@user1.friends).to include(@user2)
    end

    it 'should be pending' do
      expect(@user1.friendships.where(pending: true).length).to eq(1)
    end
  end
end
