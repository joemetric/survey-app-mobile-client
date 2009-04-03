class Survey < ActiveRecord::Base
  has_many :questions
  has_many :completions
  has_many :users, :through => :completions

  validates_presence_of :name, :amount
  validates_uniqueness_of :name
end
