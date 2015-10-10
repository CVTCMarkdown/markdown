require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
  end

  test "should get index" do
    # TEST ROUTING
    assert_routing({path: '/notes', method: 'get'}, {controller: 'notes', action: 'index'})
    assert_routing(notes_path, {controller: 'notes', action: 'index'})

    # TEST REQUEST/RESPONSE
    get :index
    assert_response :success
    
    # TEST ASSIGNS
    assert_not_nil @notes = assigns(:notes)
    assert_not_nil @trash_count = assigns(:trash_count) 
    
    # TEST FLASH MESSAGES
    
    # TEST TEMPLATE
    assert_template :index
    assert_template layout: 'application'

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
    


    assert_select "input[name=?][value=?][maxlength=?]", "note[title]", "MyString", "250"
    assert_select "input[name=?][value=?]", "note[tag_list]", ""
    assert_select "textarea[name=?]", "note[markdown]", "MyText"


    assert_select "#notice", flash[:notice]
  end

  test "should update note" do
    patch :update, id: @note, note: { markdown: @note.markdown, tags: @note.tags, title: @note.title }
    
    assert_template 'edit', locals: { note: @note }

    assert_equal 'Note was successfully updated.', flash[:notice]
  end

  test "should send note to trashcan" do

    assert_difference("Note.where('active=?', false).count", 1) do
      assert_difference("Note.where('active=?',true).count", -1) do
        delete :destroy, id: @note
      end
    end

    assert_redirected_to trashed_notes_path

  end
  
  test "should share note" do
    put :share, id: @note
    assert_redirected_to edit_note_path
  end
  
  test "should unshare note" do
    put :unshare, id: @note
    assert_redirected_to edit_note_path
  end
  
  test "should autocomplete tags" do
    xhr :post, :autocomplete_tag_name, term:"tag"
    assert_response :success
    body = JSON.parse response.body
    assert_equal 3, body.count 
    
  end
  
end
