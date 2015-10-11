require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  setup do
    sign_in users(:vhazen)
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
