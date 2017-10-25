class Area < ApplicationRecord
  has_many :demands
  has_many :users
  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions
end
