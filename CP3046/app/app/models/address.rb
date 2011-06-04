# An Address has:
# line1:: A first line
# line2:: A second line
# city::  A city 
# state:: A state 
# postcode:: A postcode 
class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  # validates :postcode, :numericality => true, :length => { :minimum => 4 }

  # Inspect the attributes of the addess
  def to_s
    attributes.inspect
  end
end
