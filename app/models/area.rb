class Area < ApplicationRecord
  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions
end