require "constants"

class Demand < ApplicationRecord
  belongs_to :user
  belongs_to :area
  belongs_to :problem
  has_many :user_demands
  validates :user, :area, :solution, presence: true
  validates :topic, inclusion: { in: Constants::DEMAND_TOPICS }, allow_nil: true

  delegate :name, to: :problem
  attr_accessor :is_statewide

  before_create :create_user_demand

  def is_statewide
    self.area.type == 'State' if self.area
  end

  def problem_text
    self.problem ? self.problem.name : ''
  end

  def problem_text=(name)
    self.problem = Problem.find_or_create_by(name: name)
  end

  private

  def create_user_demand
    if user_demands.blank?
      user_demands.build(user: user)
    end
  end
end
