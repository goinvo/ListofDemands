class AreaDefinitionsRenameAreaIdToMunicipalityId < ActiveRecord::Migration[5.1]
  def change
    rename_column(:area_definitions, :area_id, :municipality_id)
    change_column(:area_definitions, :municipality_id, :integer, null: true)
    add_column(:area_definitions, :county_id, :integer)
    add_column(:area_definitions, :state_id, :integer)
  end
end
