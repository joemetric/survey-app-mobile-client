require File.dirname(__FILE__) + '/../test_helper'

class LocationTest < ActiveSupport::TestCase

  include DemographicTestSuite
  run_demographic_tests_for Location

  should_belong_to :owner

  should_require_attributes :name, :address_line1, :city, :state, :zipcode, :country, :owner

end
