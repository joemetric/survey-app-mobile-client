class Location < ActiveRecord::Base
  include Demographic

  belongs_to :owner, :polymorphic => true 

  validates_presence_of :name, :address_line1, :city, :state, :zipcode, :country, :owner
end
