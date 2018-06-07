class AreaDefinition < ApplicationRecord
  belongs_to :zip_code

  # Need to set 'optional: true' because otherwise Rails assumes the record
  # needs :municipality_id, :county_id, :state_id, and :country_id in order to be a valid
  # creation in the DB. All the appropriate records _should_ exist anyway though ;).
  belongs_to :municipality, optional: true
  belongs_to :county, optional: true
  belongs_to :state, optional: true
  belongs_to :country, optional: true
end
