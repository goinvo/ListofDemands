class CreateZipCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_codes do |t|
      t.string        :zip, null: false
      t.string        :city
      t.string        :state
      t.string        :state_abbreviation
      t.string        :county
      t.decimal       :latitude, precision: 7, scale: 4
      t.decimal       :longitude, precision: 7, scale: 4
    end

    add_index(:zip_codes, :zip, unique: true)
  end
end
