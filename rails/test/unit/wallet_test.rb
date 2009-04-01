require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  context "A wallet" do
    should "be created with a balance of 0.0" do
      w = Wallet.create({:user => users(:quentin)})
      assert_equal 0.0, w.balance
    end
    
    should "render json" do
      assert_match /"balance": 123.0/, Wallet.create({:user => users(:quentin), :balance => 123.00}).to_json
    end
  end
end
