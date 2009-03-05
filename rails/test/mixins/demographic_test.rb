class IncompatibleDemographicType
end

module DemographicTestSuite

  def self.included target
    target.extend TestMethods
  end

  module TestMethods
    def demographic_tests
      proc { |klass|
        context "when providing required API" do

          setup do
            @this_model = klass.new
            @incompatible_model = IncompatibleDemographicType.new
          end

          context "when determining whether it is within another demographic" do

            should "understand the concept of 'within'" do
              assert @this_model.respond_to?(:within?)
            end

            should "not consider itself within demographics of incompatible types" do
              assert_raise(Demographic::IncompatibleDemographic) { !@this_model.within?(@incompatible_model) }
            end

            should "consider itself within itself" do
              assert @this_model.within?(@this_model)
            end

            context "when the base cases have been passed" do

              setup do
                @this_model = flexmock(klass.new)
                @compatible_model = flexmock(klass.new)
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

    def run_demographic_tests_for klass
      demographic_tests.call klass
    end
  end

end

