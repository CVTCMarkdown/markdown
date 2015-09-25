class AddTagToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :tags, :string
    add_index :notes, :tags
  end
end
