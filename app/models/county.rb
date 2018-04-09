class County < Area
  has_one :area_definition

  def state
    self.zip_codes.first.state
  end

  def name_abbreviated
    "#{self.short_name}, #{self.zip_codes.first.state_abbreviation}"
  end
end
