class AddSharedTokenToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :shared_token, :string
  end
end
