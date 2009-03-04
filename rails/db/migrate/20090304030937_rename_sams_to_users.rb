class RenameSamsToUsers < ActiveRecord::Migration
  def self.up
    rename_table :sams, :users
  end

  def self.down
    rename_table :users, :sams
  end
end
