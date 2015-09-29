require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get related_notes" do
    get :related_notes
    assert_response :success
  end

end
