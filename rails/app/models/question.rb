class Question < ActiveRecord::Base
  belongs_to :survey

  validates_presence_of :text
  validates_uniqueness_of :text, :scope => :survey_id
end
