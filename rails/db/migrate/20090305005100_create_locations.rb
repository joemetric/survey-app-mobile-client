class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :owner_id
      t.string  :owner_type

      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country, :default =>  "AMERRRRICA! FUCK YYEEAAH!"

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
