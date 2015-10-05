require 'test_helper'

class TrashedNotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:deletedNote)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get update" do

    assert_difference("Note.where('active=?', false).count", -1) do
      assert_difference("Note.where('active=?',true).count", 1) do
        patch :update, id: @note
      end
    end

    assert_redirected_to trashed_notes_path

    assert_equal 'Note was successfully restored.', flash[:notice]

  end

  test "should get destroy" do
    assert_difference("Note.where('active=?', false).count", -1) do
      assert_difference("Note.count", -1) do
        delete :destroy, id: @note
      end
    end

    assert_redirected_to trashed_notes_path

    assert_equal 'Note was successfully destroyed.', flash[:notice]

  end

end
