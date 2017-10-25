class CreateUserDemands < ActiveRecord::Migration[5.1]
  def change
    create_table :user_demands do |t|
      t.belongs_to          :user
      t.belongs_to          :demand
      t.timestamps
    end
  end
end
