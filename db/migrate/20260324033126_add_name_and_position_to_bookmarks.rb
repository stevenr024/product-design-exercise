class AddNameAndPositionToBookmarks < ActiveRecord::Migration[8.1]
  def change
    add_column :bookmarks, :name, :string
    add_column :bookmarks, :position, :integer
  end
end
