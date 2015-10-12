require 'test_helper'

class LayoutViewsTest < ActionView::TestCase
  include Devise::TestHelpers
  
  setup do
    
    @user = User.create(email: 'user@markdown.com', password: 'password')
    @user2 = User.create(email: 'user2@markdown.com', password: 'password')

    sign_in @user

    @note1 = Note.create(title: 'title1', markdown:'markdown1', active:true)
    @user.note << @note1
    @user.tag(@note1, :with => 'tag1, tag2, tag3', :on => 'tags')

    @note2 = Note.create(title: 'title2', markdown: 'markdown2', active:false)
    @user.note << @note2
    @user.tag(@note2, :with => 'tag3, tag4, tag5', :on => 'tags')

    @note3 = Note.create(title: 'title3', markdown: 'markdown3', active: true)
    @user2.note << @note3
    @user2.tag(@note3, :with => 'tag1, tag2, tag3, tag4', :on => 'tags')
    
  end
  
  test "application layout has global links" do
    render file: 'layouts/application'
    
    assert_select "a", {text: @user.email}
    assert_select 'a[herf=?]', dashboard_path, {text: 'Dashboard'}
    assert_select 'a[herf=?]', new_note_path, {text: 'New Note'}
    assert_select 'a[herf=?]', trashed_notes_path, {text: 'Trash Can'}
    assert_select 'a[herf=?]', destroy_user_session_path, {text: 'Sign Out'}
  end
  
end