class RemoveTagsFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :tags
  end
end
