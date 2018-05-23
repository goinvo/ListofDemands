class County < Area

  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions
  has_many :municipalities, through: :zip_codes, source: :municipality
  belongs_to :state

  def state
    self.zip_codes.first.state
  end

  def name_abbreviated
    "#{self.short_name}, #{self.zip_codes.first.state_abbreviation}"
  end
end
