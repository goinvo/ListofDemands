class AreaDefinition < ApplicationRecord
  belongs_to :area
  belongs_to :municipality, foreign_key: :area_id
  belongs_to :county, foreign_key: :area_id
  belongs_to :state, foreign_key: :area_id
  belongs_to :zip_code
end
