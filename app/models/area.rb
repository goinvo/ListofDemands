class Area < ApplicationRecord
  has_many :demands
  has_many :problems, through: :demands
  has_many :users

  def short_name
    self.name.split(",")[0].strip()
  end
end
