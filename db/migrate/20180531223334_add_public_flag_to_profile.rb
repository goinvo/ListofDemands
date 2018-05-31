class AddPublicFlagToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :private_user, :boolean, default: false
  end
end
