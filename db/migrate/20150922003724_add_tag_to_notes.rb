class AddTagToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :tag, :string
    add_index :notes, :tag
  end
end
