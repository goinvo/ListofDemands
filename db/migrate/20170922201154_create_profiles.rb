class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :gender
      t.date :date_of_birth
      t.string :political_party
      t.timestamps
    end
  end
end
