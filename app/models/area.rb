class Area < ApplicationRecord
  has_many :demands
  has_many :problems, through: :demands
  has_many :users
  has_many :area_definitions
  has_many :zip_codes, through: :area_definitions

  def municipality
    self.zip_codes.first.city
  end

  def state
    self.zip_codes.first.state
  end

  def county
    self.zip_codes.first.county
  end

  def demands_by_county
    demands = []
    Demand.find_each do |demand|
      if demand.area.county == self.county && demand.area.state == self.state
        demands.push(demand)
      end
    end
    demands
  end

  def demands_by_state
    demands = []
    Demand.find_each do |demand|
      if demand.area.state == self.state
        demands.push(demand)
      end
    end
    demands
  end

  def name_abbreviated
    "#{self.zip_codes.first.city}, #{self.zip_codes.first.state_abbreviation}"
  end
end
