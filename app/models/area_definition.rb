class AreaDefinition < ApplicationRecord
  belongs_to :zip_code
  belongs_to :municipality, foreign_key: :area_id
  belongs_to :county, foreign_key: :area_id
  belongs_to :state, foreign_key: :area_id
end
