require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    User.delete_all
    Note.delete_all

    @user = User.create(email: 'user@markdown.com', password: 'password')
    @user2 = User.create(email: 'user2@markdown.com', password: 'password')

    @note1 = Note.create(title: 'title1', markdown:'markdown1', active:true)
    @user.notes << @note1
    @user.tag(@note1, :with => 't1, t2, t3', :on => 'tags')

    @note2 = Note.create(title: 'title2', markdown: 'markdown2', active:false)
    @user.notes << @note2
    @user.tag(@note2, :with => 't3, t4, t5', :on => 'tags')

    @note3 = Note.create(title: 'title3', markdown: 'markdown3', active: true)
    @user2.notes << @note3
    @user2.tag(@note3, :with => 't1, t2, t3, t4, t5', :on => 'tags')

  end

  test "can get notes" do
    assert_equal :has_many, User.reflect_on_association(:notes).macro

    assert_equal [@note1, @note2], @user.notes
  end

  test "can get tags" do
    assert_equal :has_many, User.reflect_on_association(:owned_tags).macro

    assert_equal %w't1 t2 t3 t4 t5', @user.tags.pluck('name')
    assert_equal [1,1,2,1,1], @user.tags.to_a.map{|t| t.taggings_count}
  end
end
