class RemoveBalanceFromWallet < ActiveRecord::Migration
  def self.up
    remove_column :wallets, :balance
  end

  def self.down
    add_column :wallets, :balance, :default => 0.0, :null => false
  end
end
