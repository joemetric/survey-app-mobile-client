require File.dirname(__FILE__) + '/../test_helper'

class LocationTest < ActiveSupport::TestCase

  should_belong_to :owner

  should_require_attributes :name, :owner

  context "API for Demographic" do
    
    setup do
      @location = Location.new
    end

    context "when checking whether this location is within another" do
      
      setup do
        @other_location = Location.new

        @location.zipcode = '43212'
        @location.city = 'Columbus'
        @location.state = 'OH'
        @location.country = 'US of A'
      end

      should "not be within the other when the countries are not equal" do
        @other_location.country = "Not US of A"
        assert !@location.within?(@other_location)
      end

      should "be within the other when its country is nil" do
        @other_location.country = nil
        assert @location.within?(@other_location)
      end

      context "when the countries are equal" do
        
        setup do
          @other_location.country = 'US of A'
        end

        should "not be within when the states are not equal" do
          @other_location.state = 'MA'
          assert !@location.within?(@other_location)
        end

        should "be within the other when its state is nil" do
          @other_location.state = nil
          assert @location.within?(@other_location)
        end
        
        context "and the states are equal" do
          
          setup do
            @other_location.state = 'OH'
          end

          should "not be within when the cities are not equal" do
            @other_location.city = 'Cleveland'
            assert !@location.within?(@other_location)
          end

          should "be within when the other city is nil" do
            @other_location.city = nil
            assert @location.within?(@other_location)
          end

          context "and the cities are equal" do
            
            setup do
              @other_location.city = 'Columbus'
            end

            should "not be within when the zipcodes are not equal" do
              @other_location.zipcode = '44122'
              assert !@location.within?(@other_location)
            end

            should "be within when the other zipcode is nil" do
              @other_location.zipcode = nil
              assert @location.within?(@other_location)
            end

          end
        end
      end
    end
  end
end
