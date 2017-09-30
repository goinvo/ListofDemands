class CreateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|
      t.string      :name
      t.timestamps
    end

    add_index(:areas, :name, unique: true)
  end
end
