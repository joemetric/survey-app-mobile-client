class Survey < ActiveRecord::Base
  has_many :questions
  has_many :completions
  has_many :users, :through => :completions

  validates_presence_of :name, :amount
  validates_uniqueness_of :name

  def bundle
    attributes_hash = attributes.dup
    attributes_hash["questions"] = []
    
    questions.each do |question|
      attributes_hash["questions"] << question.attributes
    end
    
    attributes_hash
  end
end
