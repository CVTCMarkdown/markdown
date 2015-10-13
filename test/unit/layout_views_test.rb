require 'test_helper'

class LayoutViewsTest < ActionView::TestCase
  include Devise::TestHelpers
  
  setup do
    @user = User.create(email: 'user@markdown.com', password: '12345678')
    @user2 = User.create(email: 'user2@markdown.com', password: 'password')

    sign_in @user
  end
  
  test "application layout has global links" do
    render file: 'layouts/application'#, locals: {current_user: @user}
    
    assert_select 'a[href=?]', edit_user_registration_path, {text: @user.email}
    assert_select 'a[href=?]', dashboard_path, {text: 'Dashboard'}
    assert_select 'a[href=?]', new_note_path, {text: 'New Note'}
    assert_select 'a[href=?]', trashed_notes_path, {text: 'Trash Can'}
    assert_select 'a[href=?]', destroy_user_session_path, {text: 'Sign Out'}
  end
  
end