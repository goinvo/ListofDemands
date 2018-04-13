class County < Area
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
