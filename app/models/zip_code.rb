class ZipCode < ApplicationRecord
  has_one :area_definition

  has_one :municipality, through: :area_definition

  # gotta rename the `state` and `county` column on this table for these to work
  # has_one :county, through: :area_definition
  # has_one :state, through: :area_definition
end
