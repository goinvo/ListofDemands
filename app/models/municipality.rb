class Municipality < Area
  has_one :area_definition
  has_one :zip_code, through: :area_definition
  # has_one :county, through: :zip_code
  # has_one :state, through: :zip_code
end
