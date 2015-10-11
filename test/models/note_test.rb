require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  setup do
    @note = notes(:one)

    Note.delete_all
    Note.create(title: 'title 1', markdown: 'markdown', active: true)
    Note.create(title: 'title 2', markdown: 'markdown', active: true)
    Note.create(title: 'title 3', markdown: 'markdown', active: true)
    Note.create(title: 'title 4', markdown: 'markdown', active: false)
  end

  test "can get recent notes" do
    assert_equal 'title 4', Note.most_recent(1).last.title
    assert_equal 'title 3', Note.most_recent(2).last.title
    assert_equal 'title 2', Note.most_recent(3).last.title
  end

  test "can get active notes" do
    assert_not Note.active.exists?(active: false)
    assert_equal 3, Note.active.count
  end

  test "can get inactive notes" do
    assert_not Note.inactive.exists?(active: true)
    assert_equal 1, Note.inactive.count
  end

  test "can search with text" do
    @note_in_question = Note.create(title: 'with text example', markdown: 'markdown is awesome sauce')

    @notes = Note.with_text 'awesome sauce'
    assert_equal @note_in_question, @notes.first

    @notes = Note.with_text 'example'
    assert_equal @note_in_question, @notes.first

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
