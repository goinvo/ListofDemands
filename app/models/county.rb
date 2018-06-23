class County < Area

  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions
  has_many :municipalities, through: :zip_codes, source: :municipality

  def state
    area_definitions.first.state
  end

  def country
    area_definitions.first.country
  end

  def name_abbreviated
    "#{short_name}, #{zip_codes.first.state_abbreviation}"
  end
end
