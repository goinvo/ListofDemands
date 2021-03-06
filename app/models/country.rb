class Country < Area
  has_many :area_definitions
  has_many :municipalities, -> { distinct }, through: :area_definitions, source: :municipality, class_name: "Municipality"
  has_many :counties, -> { distinct }, through: :area_definitions, source: :county, class_name: "County"
  has_many :states, -> { distinct }, through: :area_definitions, source: :state, class_name: "State"
  has_many :zip_codes, through: :area_definitions
end
