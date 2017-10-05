class CreateDemands < ActiveRecord::Migration[5.1]
  def change
    create_table :demands do |t|
      t.belongs_to    :user
      t.belongs_to    :area
      t.string        :name, null: false
      t.string        :why, null: false
      t.string        :how, null: false
      t.timestamps
    end
  end
end
