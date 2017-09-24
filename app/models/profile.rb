class Profile < ApplicationRecord
  belongs_to :user

  validates :address1, :city, :state, :zip, presence: true
end
