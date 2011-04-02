ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'fake_data'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  setup :activate_authlogic
end
