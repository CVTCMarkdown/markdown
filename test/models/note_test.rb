require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  setup do
    @note = notes(:one)
  end
  
  test "can share" do
    @note.share
    assert !@note.shared_token.blank?
  end
  
  test "can unshare" do
    @note.share
    @note.unshare
    assert @note.shared_token.blank?
  end

  test "can't save without title" do
    @note.title = nil
    assert_not @note.save
  end

  test "can't save without markdown" do
    @note.markdown = nil
    assert_not @note.save
  end

  test "can't save with title over 250 characters" do
    @note.title = "title" * 51
    assert_not @note.save
  end
end
