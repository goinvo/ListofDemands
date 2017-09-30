class ZipCode < ApplicationRecord
  has_many :area_definitions
  has_many :areas, through: :area_definitions
end
