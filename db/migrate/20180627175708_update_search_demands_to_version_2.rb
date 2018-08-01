class UpdateSearchDemandsToVersion2 < ActiveRecord::Migration[5.2]
  def change
    update_view :search_demands,
      version: 2,
      revert_to_version: 1,
      materialized: true
  end
end
