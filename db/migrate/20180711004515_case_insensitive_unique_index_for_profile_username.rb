class CaseInsensitiveUniqueIndexForProfileUsername < ActiveRecord::Migration[5.2]
  def up
    remove_index :profiles, :username
    add_index :profiles, "lower(username)", name: "index_profiles_on_lower_username", unique: true
  end

  def down
    remove_index :profiles, :username
    add_index :profiles, :username, unique: true
  end
end
