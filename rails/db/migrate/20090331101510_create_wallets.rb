class CreateWallets < ActiveRecord::Migration
  def self.up
    create_table :wallets do |t|
      t.belongs_to :user
      t.float :balance, :default => 0.0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :wallets
  end
end
