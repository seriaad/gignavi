class AddUniqueIndexToUsersDisplayName < ActiveRecord::Migration[7.2]
  def change
    add_index :users, :display_name, unique: true
  end
end
