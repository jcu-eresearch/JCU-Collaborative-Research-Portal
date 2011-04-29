require 'test_helper'

class ResearcherTest < ActiveSupport::TestCase
  test "should not save researcher without name" do
    researcher = Researcher.new
	researcher.jc_number = 'jc111'
	assert !researcher.save
  end

  test "should not save researcher without jc_number" do
    researcher = Researcher.new
	researcher.name = 'Joe'
	assert !researcher.save
  end
end
