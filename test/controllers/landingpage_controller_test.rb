require 'test_helper'

class LandingpageControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    
    assert_select 'form[id=?][action=?]', "SignUp", "/users/sign_up"
    assert_select 'form[id=?][action=?]', "SignIn", "/users/sign_in"
    
  end
    
end
