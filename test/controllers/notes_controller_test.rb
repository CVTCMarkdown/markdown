require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @user = User.create(email: 'user@markdown.com', password: 'password')
    @user2 = User.create(email: 'user2@markdown.com', password: 'password')

    sign_in @user

    @note1 = Note.create(title: 'title1', markdown:'markdown1', active:true)
    @user.notes << @note1
    @user.tag(@note1, :with => 'tag1, tag2, tag3', :on => 'tags')

    @note2 = Note.create(title: 'title2', markdown: 'markdown2', active:false)
    @user.notes << @note2
    @user.tag(@note2, :with => 'tag3, tag4, tag5', :on => 'tags')

    @note3 = Note.create(title: 'title3', markdown: 'markdown3', active: true)
    @user2.notes << @note3
    @user2.tag(@note3, :with => 'tag1, tag2, tag3, tag4, tag5, tag6', :on => 'tags')

  end

  test "should get index" do
    # TEST ROUTING
    assert_routing({path: '/notes', method: 'get'}, {controller: 'notes', action: 'index'})
    assert_routing(notes_path, {controller: 'notes', action: 'index'})

    # TEST REQUEST/RESPONSE
    get :index
    assert_response :success
    
    # TEST ASSIGNS
    assert_not_nil notes = assigns(:notes)
    assert_not_nil trash_count = assigns(:trash_count) 
    
    # TEST FLASH MESSAGES
    
    # TEST TEMPLATE
    assert_template :index
    assert_template layout: 'application'

    # TEST VIEWS
    # TODO - move the notes list to a partial and assert that the template uses it
    assert_select "table#note_list" do
      assert_select "th.note.title", {text: 'Title'}
      assert_select "th.note.last-update", {text: 'Last Updated'}
      
      notes.each do |note|
        assert_select 'td.note.title > a[href=?]', edit_note_path(note), {text: note.title}
        assert_select 'td.note.last-update', {text: note.updated_at.to_s}
      end
      
    end
    
    assert_select "a[href=?]", trashed_notes_path, {text: "Trash Can (#{trash_count})"}

  end

  test "should get new" do
    # TEST ROUTING
    assert_routing({path: '/notes/new', method: 'get'}, {controller: 'notes', action: 'new'})
    assert_routing(new_note_path, {controller: 'notes', action: 'new'})

    # TEST REQUEST/RESPONSE
    get :new
    assert_response :success
    
    # TEST ASSIGNS
    assert_not_nil assigns(:note)
    
    # TEST FLASH MESSAGES
    
    # TEST TEMPLATE
    assert_template :new
    assert_template layout: 'application'
  end

  test "should create note" do
    # TEST ROUTING
    assert_routing({path: '/notes', method: 'post'}, {controller: 'notes', action: 'create'})
    assert_routing({path: notes_path, method: 'post'}, {controller: 'notes', action: 'create'})

    # TEST REQUEST/RESPONSE
    assert_difference('Note.count') do
      post :create, note: { markdown: @note1.markdown, tags: @note1.tags, title: @note1.title }
    end

    # TEST ASSIGNS
    assert_not_nil assigns(:note)

    # TEST FLASH MESSAGES
    assert_equal 'Note was successfully created.', flash[:notice]

    # TEST TEMPLATE
    assert_template 'edit', locals: { note: @note1 }
    assert_template layout: 'application', partial: '_form'
  end

  test "should get edit" do



    # TEST ROUTING
    #assert_routing({path: "/notes/#{@note1.id}/edit", method: 'get', id: @note1.id }, {controller: 'notes', action: 'edit', id: @note1.id})
    #assert_routing(edit_note_path(@note1), {controller: 'notes', action: 'edit', id: @note1})

    # TEST REQUEST/RESPONSE
    get :edit, id: @note1
    assert_response :success

    # TEST ASSIGNS
    assert_not_nil assigns(:note)

    # TEST FLASH MESSAGES
    assert_select "#notice", flash[:notice]

    # TEST TEMPLATE
    assert_template 'edit', locals: { note: @note1 }
    assert_template layout: 'application', partial: '_form'

    # TEST VIEWS
    assert_select "h1" do
      assert_select "+a.fa-arrow-left[href=?]", notes_path do
        assert_select "+a.fa-share-square-o[href=?]", share_note_path(@note1) do
          assert_select "+a.fa-trash-o[href=?][data-method=?]", note_path(@note1), 'delete'
        end
      end
    end

    assert_select "input[name=?][value=?][maxlength=?]", "note[title]", @note1.title, "250"
    assert_select "input[name=?][value=?]", "note[tag_list]", ""
    assert_select "textarea[name=?]", "note[markdown]", @note1.markdown
  end

  test "should update note" do
    patch :update, id: @note1, note: { markdown: @note1.markdown, tags: @note1.tags, title: @note1.title }
    
    assert_template 'edit', locals: { note: @note1}

    assert_equal 'Note was successfully updated.', flash[:notice]
  end

  test "should send note to trashcan" do

    assert_difference("Note.where('active=?', false).count", 1) do
      assert_difference("Note.where('active=?',true).count", -1) do
        delete :destroy, id: @note1
      end
    end

    assert_redirected_to trashed_notes_path

  end
  
  test "should share note" do
    put :share, id: @note1
    assert_redirected_to edit_note_path
  end
  
  test "should unshare note" do
    put :unshare, id: @note1
    assert_redirected_to edit_note_path
  end
  
  test "should autocomplete tags" do
    xhr :post, :autocomplete_tag_name, term:"tag"
    assert_response :success
    body = JSON.parse response.body
    assert_equal 6, body.count
    
  end
  
end
