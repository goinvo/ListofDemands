class Demand < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :user_demands
  validates :user, :area, :name, :why, :how, presence: true
end
