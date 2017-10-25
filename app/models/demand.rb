class Demand < ApplicationRecord
  belongs_to :user
  belongs_to :area
  belongs_to :problem
  has_many :user_demands
  validates :user, :area, :problem, :solution, presence: true

  delegate :name, to: :problem
end
