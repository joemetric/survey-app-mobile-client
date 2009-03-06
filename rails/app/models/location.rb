class Location < ActiveRecord::Base
  include Demographic

  OrderedAttributes = %w( country state city zipcode )

  belongs_to :owner, :polymorphic => true 

  validates_presence_of :name, :owner

  def within_check other_location
    OrderedAttributes.all? do |attr| 
      other_location.send(attr).nil? || send(attr) == other_location.send(attr)
    end
  end

end
