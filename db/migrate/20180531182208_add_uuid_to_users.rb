class AddUuidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uuid, :uuid, null: false, index: true, unique: true, default: "uuid_generate_v4()"
  end
end
