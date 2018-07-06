class AddUsernameToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :username, :string
    add_index :profiles, :username, unique: true
  end
end
