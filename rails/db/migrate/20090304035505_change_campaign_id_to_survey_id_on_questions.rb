class ChangeCampaignIdToSurveyIdOnQuestions < ActiveRecord::Migration
  def self.up
    rename_column :questions, :campaign_id, :survey_id
  end

  def self.down
    rename_column :questions, :survey_id, :campaign_id
  end
end
