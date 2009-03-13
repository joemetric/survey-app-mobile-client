class AddDemographicDataToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :birthdate, :date
    add_column :users, :income,    :integer
    add_column :users, :gender,    :string
  end

  def self.down
    remove_column :users, :gender
    remove_column :users, :income
    remove_column :users, :birthdate
  end
end
