class RemoveAmountFromQuestionAndMakeBelongToCampaign < ActiveRecord::Migration
  def self.up
    remove_column :questions, :amount
    add_column :questions, :campaign_id, :integer
  end

  def self.down
    remove_column :questions, :campaign_id
    add_column :questions, :amount, :float
  end
end
