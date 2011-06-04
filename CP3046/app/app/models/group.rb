# A Group has a:
# name::              The name of the Group (must be unique, can't be changed)
# researchers::       The members of the Group
class Group < ActiveRecord::Base
  # No two groups can have the same name.
  # A group must have a name
  validates :name, :presence => true, :uniqueness => true

  # A group's name can't change
  attr_readonly :name

  # A group has many researchers.
  # A researcher may belong to many groups.
  has_and_belongs_to_many :researchers
end
