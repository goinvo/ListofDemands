class UserDemand < ApplicationRecord
  belongs_to :user
  belongs_to :demand

  default_scope -> { order("priority asc") }

  before_validation :set_priority, on: :create

  validates :priority, presence: true, numericality: {greater_than: 0}
  validates :user, uniqueness: { scope: :demand }

  delegate :problem, :area, to: :demand

  def set_priority
    if priority.blank?
      assign_attributes(priority: user.user_demands.count + 1)
    end
  end
end
