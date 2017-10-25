class AddUserDemandsConstraints < ActiveRecord::Migration[5.1]
  def change
    add_index(:user_demands, [:demand_id, :user_id], unique: true)
  end
end
