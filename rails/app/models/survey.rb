class Survey < ActiveRecord::Base
  has_many :questions

  validates_presence_of :name, :amount
  validates_uniqueness_of :name
end
