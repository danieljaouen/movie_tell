require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'valid scenarios' do
    subject do
      User.new(email: 'user@example.com',
               password: 'secrettt',
               password_confirmation: 'secrettt')
    end
    it { should be_valid }
  end

  describe 'invalid scenarios' do
    describe 'invalid user without email' do
      subject do
        User.new(password: 'secret',
                 password_confirmation: 'secret')
      end
      it { should_not be_valid }
    end

    describe 'invalid user without password' do
      subject do
        User.new(email: 'user@example.com',
                 password: 'one',
                 password_confirmation: 'two')
      end
      it { should_not be_valid }
    end
  end
end
