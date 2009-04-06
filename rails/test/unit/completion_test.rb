require 'test_helper'

class CompletionTest < ActiveSupport::TestCase
  context "A New completion" do
    should "trigger a new wallet_transaction in after_create" do
      quentin = users(:quentin)
      survey = Survey.first
      mockwallet = flexmock(wallets(:quentins_wallet))
      mockwallet.should_receive :record_completed_survey, :with => survey
      quentin.wallet = mockwallet
      completion = Completion.create( :user => quentin, :survey => survey )
    end
  end
end
