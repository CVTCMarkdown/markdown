class DashboardController < ApplicationController
  def show
    @notes = Note.where(active: true).order(:updated_at).limit(10)
    @tags = ActsAsTaggableOn::Tag.most_used(10)
  end
end
