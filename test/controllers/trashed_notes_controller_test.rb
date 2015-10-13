require 'test_helper'

class TrashedNotesControllerTest < ActionController::TestCase
  setup do
    @user = User.create(email: 'user@markdown.com', password: 'password')
    @user2 = User.create(email: 'user2@markdown.com', password: 'password')

    sign_in @user

    @note = Note.create(title: 'title1', markdown:'markdown1', active:false)
    @user.notes << @note
    @user.tag(@note, :with => 'tag1, tag2, tag3', :on => 'tags')

    @note2 = Note.create(title: 'title2', markdown: 'markdown2', active:false)
    @user.notes << @note2
    @user.tag(@note2, :with => 'tag3, tag4, tag5', :on => 'tags')

    @note3 = Note.create(title: 'title3', markdown: 'markdown3', active: true)
    @user2.notes << @note3
    @user2.tag(@note3, :with => 'tag1, tag2, tag3, tag4, tag5, tag6', :on => 'tags')
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
