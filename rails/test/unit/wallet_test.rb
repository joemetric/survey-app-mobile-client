require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  context "A wallet" do
    should "be created with a balance of 0.0" do
      w = Wallet.create({:user => users(:quentin)})
      assert_equal 0.0, w.balance
      assert w.wallet_transactions.empty?
    end
    
    should "render json" do
      assert_match /"balance": 0/, Wallet.new({:user => users(:quentin)}).to_json(:methods => :balance)
    end

    should "record a transaction for a completed survey" do
      wallet = wallets(:quentins_wallet)
      survey = Survey.new(:amount => 1.50, :name => "My Survey")
      assert wallet.wallet_transactions.empty?
      wallet.record_completed_survey( survey )
      assert_equal 1, wallet.wallet_transactions.size
      assert_equal 1.50, wallet.wallet_transactions.first.amount
      assert_equal "My Survey", wallet.wallet_transactions.first.description
      assert_equal 1.50, wallet.balance
    end
    
    should "record a transaction with negative amount for a withdrawal" do
      wallet = wallets(:quentins_wallet)
      assert wallet.wallet_transactions.empty?
      wallet.record_withdrawal( 2.00 )
      assert_equal 1, wallet.wallet_transactions.size
      assert_equal -2.00, wallet.wallet_transactions.first.amount
      assert_equal "Withdrawal", wallet.wallet_transactions.first.description
      assert_equal -2.00, wallet.balance
    end
  end
end
