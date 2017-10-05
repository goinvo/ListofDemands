class ZipCode < ApplicationRecord
  has_one :area_definition
  has_one :area, through: :area_definition
end
