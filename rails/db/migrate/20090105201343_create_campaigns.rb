class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name
      t.float  :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
