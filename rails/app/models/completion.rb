class Completion < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  
  after_create :update_wallet
  
  def update_wallet
    user.wallet.record_completed_survey( survey )
  end
end
