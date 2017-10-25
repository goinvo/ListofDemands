class Problem < ApplicationRecord
  has_many :demands
  validates :name, presence: true
end
