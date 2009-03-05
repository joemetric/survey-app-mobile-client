module DemographicTest

  def self.included target
    target.extend(ClassMethods)
  end

  module ClassMethods
    def demographic_tests
      proc { |klass|
        context "some stuff" do

          setup do
            @model = klass.new
          end

          should "know its comparand" do
            assert @model.respond_to?(:comparand)
          end

        end
      }
    end

    def run_demographic_tests_for klass
      demographic_tests.call(klass)
    end
  end

end

