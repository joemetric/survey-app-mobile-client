class Question < ActiveRecord::Base
  belongs_to :campaign

  validates_presence_of :text
  validates_uniqueness_of :text, :scope => :campaign_id
end
