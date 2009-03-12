require File.dirname(__FILE__) + '/../test_helper'

class AgeTest < Test::Unit::TestCase

  context "Initializer" do
    
    should "set birthdate" do
      age = Age.new :birthdate
      assert_equal age.birthdate, :birthdate
    end

  end

  context "when checking whether this age is within another" do
    
    setup do
      @age = Age.new 10.years.ago.to_date
    end
    
    should "be true when the age is the minimum" do
      assert @age.within?(10, 15)
    end
    
    should "be true when the birthdate falls within the range of ages" do
      assert @age.within?(5, 15)
    end
    
    should "be true when the age is the maximum" do
      assert @age.within?(5, 10)
    end
    
    should "be false when the birthdate when it is less than the minimum age" do
      assert !@age.within?(15, 20)
    end
    
    should "be false when the birthdate when it is greater than the maximum age" do
      assert !@age.within?(5, 9)
    end

  end

end
