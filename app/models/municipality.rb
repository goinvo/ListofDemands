class Municipality < Area
  def county
    self.zip_codes.first.county
  end

  def state
    self.zip_codes.first.state
  end

  def name_abbreviated
    "#{self.zip_codes.first.city}, #{self.zip_codes.first.state_abbreviation}"
  end
end
