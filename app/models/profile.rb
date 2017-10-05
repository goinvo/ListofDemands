class Profile < ApplicationRecord
  belongs_to :user
  has_one :zip_code, foreign_key: :zip, primary_key: :zip

  validates :address1, :city, :state, :zip, presence: true
end
