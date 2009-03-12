class Location < ActiveRecord::Base
  OrderedAttributes = %w( country state city zipcode )

  belongs_to :owner, :polymorphic => true 

  validates_presence_of :name, :owner
  validates_presence_of :state, :if => :city?

  def within? other_location
    OrderedAttributes.all? do |attr| 
      other_location.send(attr).nil? || send(attr) == other_location.send(attr)
    end
  end

end
