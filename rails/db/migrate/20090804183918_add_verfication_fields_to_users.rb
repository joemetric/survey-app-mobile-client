class AddVerficationFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :activation_code, :string, :limit => 40
    add_column :users, :activated_at, :datetime
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_column :users, :activated_at
    remove_column :users, :activation_code
  end
end
