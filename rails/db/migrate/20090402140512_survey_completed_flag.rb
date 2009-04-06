class SurveyCompletedFlag < ActiveRecord::Migration
  def self.up
    add_column :surveys, :complete, :boolean, :default => false
  end

  def self.down
    add_column :surveys, :complete
  end
end
