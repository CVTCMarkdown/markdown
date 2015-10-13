require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
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
    @user2.tag(@note3, :with => 'tag1, tag2, tag3, tag4', :on => 'tags')

  end

  test "should get show" do
    
    # TEST ROUTING
    assert_routing({path:"/dashboard", method:"get"},{controller:"dashboard", action:"show"})
    assert_routing(dashboard_path, {controller: 'dashboard', action: 'show'})

    # TEST REQUEST/RESPONSE
    get :show
    assert_response :success

    # TEST ASSIGNS
    assert_not_nil @notes = assigns(:notes)
    assert_not_nil @tags = assigns(:tags)

    # TEST FLASH MESSAGES

    # TEST TEMPLATE & PARTIALS
    assert_template :show
    assert_template layout: 'application', partial: 'tags/_show'

    # TEST VIEWS
    assert_select "a[href=?]", new_note_path, {text: 'New Note'}
    assert_select "form#search_form[action=?]", "/notes"

    # TODO - move the notes list to a partial and assert that the template uses it
    assert_select "#recent_notes>h3", {text: 'Recent Notes'}
    assert_select "table#note_list" do
      assert_select "th", {text: 'Title'}
      assert_select "th", {text: 'Last Updated'}
      
      @notes.each do |note|
        assert_select 'td > a[href=?]', edit_note_path(note), {text: note.title}
        assert_select 'td', {text: note.updated_at.to_s}
      end
      
    end
  end
  
end
