class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false

      # optional
      t.string :gender
      t.date :date_of_birth
      t.string :political_party
      t.timestamps
    end
  end
end
