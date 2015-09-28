require 'test_helper'

class SharedNoteControllerTest < ActionController::TestCase
  
  setup do
    @note = notes(:one)
    @note.share
    @note.save
    @note.reload
  end
  
  test "should get shared_note" do
    get :show, shared_token: @note.shared_token
    assert_response :success
    
    assert_template 'show', locals: { note: @note }

  end
  

end
