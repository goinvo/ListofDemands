class Municipality < Area

  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions

  validates :name, uniqueness: true

  def county
    self.area_definitions.first.county
  end

  def state
    self.area_definitions.first.state
  end

  def name_abbreviated
    "#{self.zip_codes.first.city}, #{self.zip_codes.first.state_abbreviation}"
  end

  def municipalities
    [self]
  end
end
