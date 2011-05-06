require 'test_helper'

class TextilesControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:one)
  end
  
  test "should get preview" do
    post :preview, nil, { :jc_number => @researcher.to_param }
    assert_response :success
  end
end
