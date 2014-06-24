require 'capybara/rspec'
require 'devise'
require 'factory_girl_rails'
require './spec/support/controller_macros.rb'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers
  config.include Warden::Test::Helpers
  config.extend ControllerMacros, type: :controller
end
