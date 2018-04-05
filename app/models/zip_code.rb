class ZipCode < ApplicationRecord
  has_one :area_definition

  has_one :municipality, through: :area_definition
  has_one :county, through: :area_definition
  has_one :state, through: :area_definition
end
