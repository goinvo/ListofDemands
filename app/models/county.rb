class County < Area

  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions

  def municipalities
    self.zip_codes.map { |zip| zip.municipality }
  end

  def state
    self.zip_codes.first.state
  end

  def name_abbreviated
    "#{self.short_name}, #{self.zip_codes.first.state_abbreviation}"
  end
end
