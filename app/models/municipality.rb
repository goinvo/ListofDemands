class Municipality < Area

  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions

  validates :name, uniqueness: true

  def county
    area_definitions.first.county
  end

  def state
    area_definitions.first.state
  end

  def country
    area_definitions.first.country
  end

  def name_abbreviated
    "#{zip_codes.first.city}, #{zip_codes.first.state_abbreviation}"
  end

  def municipalities
    [self]
  end
end
