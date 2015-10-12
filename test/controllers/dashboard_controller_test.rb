require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get show" do
    assert_routing({path:"/dashboard", method:"get"},{controller:"dashboard", action:"show"})
    get :show
    assert_response :success
    
    assert_select "input[name=?]", "search"
  end

end
