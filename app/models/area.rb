class Area < ApplicationRecord
  has_many :demands
  has_many :problems, through: :demands
  has_many :users
end
