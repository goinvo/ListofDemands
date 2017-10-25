class UserDemand < ApplicationRecord
  belongs_to :user
  belongs_to :demand
  validates :user, uniqueness: { scope: :demand }
end
