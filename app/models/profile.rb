class Profile < ApplicationRecord
  belongs_to :user
  has_one :zip_code, foreign_key: :zip, primary_key: :zip

  validates :zip, presence: true
end
