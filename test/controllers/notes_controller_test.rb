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
  end

  test "should get edit" do
    get :edit, id: @note
    assert_response :success
    assert_select "a.fa.fa-arrow-left"
    assert_select "a.fa.fa-share-sqare-o"
    assert_select "a.fa.fa-trash-o"
  end

  test "should update note" do
    patch :update, id: @note, note: { markdown: @note.markdown, tags: @note.tags, title: @note.title }
    
    assert_template 'edit', locals: { note: @note }

    #assert_redirected_to edit_note_path(assigns(:note))
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
