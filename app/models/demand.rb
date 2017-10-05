class Demand < ApplicationRecord
  belongs_to :user
  belongs_to :area
  validates :user, :area, :name, :why, :how, presence: true
end
