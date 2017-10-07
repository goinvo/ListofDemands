class AddAreaToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column(:users, :area_id, :integer)
  end
end
