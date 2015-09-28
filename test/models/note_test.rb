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
end
