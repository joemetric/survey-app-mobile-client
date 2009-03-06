class IncompatibleType
end

module DemographicTestSuite

  def self.included target
    target.extend TestMethods
  end

  module TestMethods
    def demographic_tests
      proc { |demographic_type|
        context "when providing required API" do

          setup do
            @this_model = demographic_type.new
            @incompatible_model = IncompatibleType.new
          end

          context "when determining whether it is within another demographic" do

            should "understand the concept of 'within'" do
              assert @this_model.respond_to?(:within?)
            end

            should "have a within check" do
              assert @this_model.respond_to?(:within_check)
            end

            should "not consider itself within demographics of incompatible types" do
              assert_raise(Demographic::IncompatibleDemographic) { !@this_model.within?(@incompatible_model) }
            end

            should "consider itself within itself" do
              assert @this_model.within?(@this_model)
            end

            context "when the base cases have been passed" do

              setup do
                @this_model = flexmock(demographic_type.new)
                @compatible_model = flexmock(demographic_type.new)
              end

              should "delegate to its within check" do
                @this_model.should_receive(:within_check).with(@compatible_model)
                @this_model.within? @compatible_model
              end

            end
            
          end

        end
      }
    end

    def run_demographic_tests_for demographic_type
      demographic_tests.call demographic_type
    end
  end

end

