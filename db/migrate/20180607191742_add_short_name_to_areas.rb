class AddShortNameToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :short_name, :string, after: :name
  end
end
