class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc)
    @topscore = ActsAsTaggableOn::Tag.maximum(:taggings_count)

  end

end
