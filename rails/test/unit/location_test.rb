require File.dirname(__FILE__) + '/../test_helper'

class LocationTest < ActiveSupport::TestCase

  context "Associations" do
    should_belong_to :owner
  end

end
