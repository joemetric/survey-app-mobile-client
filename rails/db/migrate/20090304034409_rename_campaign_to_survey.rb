class RenameCampaignToSurvey < ActiveRecord::Migration
  def self.up
    rename_table :campaigns, :surveys
  end

  def self.down
    rename_table :surveys, :campaigns
  end
end
