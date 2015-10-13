class DashboardController < ApplicationController
  def show
    @notes = current_user.notes.active.most_recent(10)
    @tags = ActsAsTaggableOn::Tag.most_used(20)#current_user.notes.all_tag_counts.select(:id, :name, 'tags_count as taggings_count').most_used(20)
    @topscore = @tags.first.taggings_count unless @tags.blank?
  end

end
