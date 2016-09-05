ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Returns true if user is logged in.
  # It is paraller method to the logged_in? defined in application_helper.rb
  # controller helpers aren't available in tests by default
  # and we'll find out during tests if there is something wrong with controller
  # helper method is_logged?.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Add more helper methods to be used by all tests here...
end
