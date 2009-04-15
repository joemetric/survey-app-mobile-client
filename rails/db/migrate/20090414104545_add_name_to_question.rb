class AddNameToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :name, :string
  end

  def self.down
    remove_column :questions, :name
  end
end
