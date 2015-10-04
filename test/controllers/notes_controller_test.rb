require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, note: { markdown: @note.markdown, tags: @note.tags, title: @note.title }
    end

    assert_template 'edit', locals: { note: @note }

    #assert_redirected_to edit_note_path(assigns(:note))
    assert_equal 'Note was successfully created.', flash[:notice]
  end

  test "should get edit" do
    get :edit, id: @note
    assert_response :success

    assert_select "h1" do
      assert_select "+a.fa-arrow-left[href=?]", notes_path do
        assert_select "+a.fa-share-square-o[href=?]", share_note_path(@note) do
          assert_select "+a.fa-trash-o[href=?][data-method=?]", note_path(@note), 'delete'
        end
      end
    end
    
    #assert assigns(:notice), "Edit page should have a notice."
    assert_select "#notice", flash[:notice]
    # put_via_redirect note_path, note:@note
    # assert_equal edit_note_path, path
    
  end

  test "should update note" do
    patch :update, id: @note, note: { markdown: @note.markdown, tags: @note.tags, title: @note.title }
    
    assert_template 'edit', locals: { note: @note }

    #assert_redirected_to edit_note_path(assigns(:note))
    assert_equal 'Note was successfully updated.', flash[:notice]
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete :destroy, id: @note
    end

    assert_redirected_to notes_path
  end
  
  test "should share note" do
    put :share, id: @note
    assert_redirected_to edit_note_path
  end
  
  test "should unshare note" do
    put :unshare, id: @note
    assert_redirected_to edit_note_path
  end
end
