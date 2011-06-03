class Group < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  attr_readonly :name

  has_and_belongs_to_many :researchers
end
