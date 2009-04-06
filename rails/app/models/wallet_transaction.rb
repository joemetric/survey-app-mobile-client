class WalletTransaction < ActiveRecord::Base
  belongs_to :wallet
  validates_presence_of :amount
  validates_numericality_of :amount
  validates_presence_of :description
end
