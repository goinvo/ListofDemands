require "constants"

class Demand < ApplicationRecord
  belongs_to :user
  belongs_to :area
  belongs_to :problem
  has_many :user_demands
  has_many :demand_relationships
  has_many :related_demands, through: :demand_relationships, dependent: :destroy
  validates :user, :solution, :demand_description, presence: true
  validates_presence_of :area, message: "Must pertain to at least one area"
  validates :topic, inclusion: { in: Constants::DEMAND_TOPICS }, allow_nil: true

  delegate :name, to: :problem

  before_create :create_user_demand
  after_commit :refresh_search_demands

  def refresh_search_demands
    SearchDemand.refresh
  end

  def demand_description
    self.problem ? self.problem.name : ''
  end

  def demand_description=(name)
    self.problem = Problem.find_or_create_by(name: name)
  end

  def owned_by?(user)
    user == self.user
  end

  def related_demand_for(area)
    related_demands.find_by(area_id: area.id)
  end

  private

  def create_user_demand
    if user_demands.blank?
      user_demands.build(user: user)
    end
  end
end
