class AddCountryToAreaDefinitions < ActiveRecord::Migration[5.2]
  def change
    add_column(:area_definitions, :country_id, :integer, after: :state_id)
  end
end
