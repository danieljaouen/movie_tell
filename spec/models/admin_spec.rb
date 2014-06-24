require 'rails_helper'

RSpec.describe Admin, :type => :model do
  describe 'valid scenarios' do
    subject do
      Admin.new(email: 'admin@example.com',
                password: 'secrettt',
                password_confirmation: 'secrettt')
    end
    it { should be_valid }
  end

  describe 'invalid scenarios' do
    describe 'invalid admin without email' do
      subject do
        Admin.new(password: 'secret',
                  password_confirmation: 'secret')
      end
      it { should_not be_valid }
    end

    describe 'invalid admin without password' do
      subject do
        Admin.new(email: 'admin@example.com',
                  password: 'one',
                  password_confirmation: 'two')
      end
      it { should_not be_valid }
    end
  end
end
