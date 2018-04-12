class AreaDefinition < ApplicationRecord
  belongs_to :zip_code

  # Need to set 'optional: true' because otherwise Rails assumes the record
  # needs :municipality_id, :county_id, and :state_id in order to be a valid
  # creation in the DB. All the appropriate records _should_ exist anyway though ;).
  belongs_to :municipality, foreign_key: :area_id, optional: true
  belongs_to :county, foreign_key: :area_id, optional: true
  belongs_to :state, foreign_key: :area_id, optional: true
end
