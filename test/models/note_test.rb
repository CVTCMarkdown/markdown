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

  test "can save multiple tags delimited by comma" do
    @note.tag_list = "tag1, tag2, tag3"
    assert_difference "ActsAsTaggableOn::Tagging.count", 3 do
      @note.save
    end
  end

  test "can throw away and restore note" do
    @note.throw_away
    assert_not @note.active

    @note.restore
    assert @note.active
  end
end
