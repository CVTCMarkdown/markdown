class AddActiveToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :active, :boolean
  end
end
