class Location < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true 

  validates_presence_of :name, :address_line1, :city, :state, :zipcode, :country, :owner

  def comparand
  end
end
