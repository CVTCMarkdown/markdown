class DashboardController < ApplicationController
  def show
    @notes = Note.where(active: true).order(updated_at: :desc).limit(10)
    @tags = ActsAsTaggableOn::Tag.most_used(100)
    @topscore = ActsAsTaggableOn::Tag.maximum(:taggings_count)
  end

end
