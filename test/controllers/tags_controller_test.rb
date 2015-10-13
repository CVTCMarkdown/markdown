require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:vhazen)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end


# EXAMPLE OF TESTING A PARTIAL

class TagsViewsTest < ActionView::TestCase
  setup do
    @tag = ActsAsTaggableOn::Tag.create(name: 'tag1', taggings_count: 3)
  end
  
  test "_show partial has correct layout" do
    render 'tags/show', :tag => @tag, :topscore => 10
    
    assert_select "a[href=?]", '#', {text: @tag.name}
  end
  
end
