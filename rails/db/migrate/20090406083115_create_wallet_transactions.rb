class CreateWalletTransactions < ActiveRecord::Migration
  def self.up
    create_table :wallet_transactions do |t|
      t.integer :wallet_id
      t.float :amount
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :wallet_transactions
  end
end
