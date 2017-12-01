class Demand < ApplicationRecord
  belongs_to :user
  belongs_to :area
  belongs_to :problem
  has_many :user_demands
  validates :user, :area, :problem, :solution, presence: true

  delegate :name, to: :problem
  attr_accessor :problem_text

  def problem_text=(name)
    self.problem = Problem.find_or_create_by(name: name)
  end
end
