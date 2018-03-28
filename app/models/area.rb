class Area < ApplicationRecord
  has_many :demands
  has_many :problems, through: :demands
  has_many :users
  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions

  def name_abbreviated
    "#{self.zip_codes.first.city}, #{self.zip_codes.first.state_abbreviation}"
  end
end
