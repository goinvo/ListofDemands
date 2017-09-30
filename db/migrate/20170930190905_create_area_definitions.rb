class CreateAreaDefinitions < ActiveRecord::Migration[5.1]
  def change
    create_table :area_definitions do |t|
      t.belongs_to    :area, null: false
      t.belongs_to    :zip_code, null: false
      t.timestamps
    end

    add_index(:area_definitions, [:area_id, :zip_code_id], unique: true)
  end
end
