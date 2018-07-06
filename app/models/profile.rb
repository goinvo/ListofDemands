class Profile < ApplicationRecord
  belongs_to :user
  has_one :zip_code, foreign_key: :zip, primary_key: :zip

  validates :zip, :name, presence: true
  validates :username, uniqueness: true, format: { with: /\A(?=.*[a-z])[a-z\d\-\_]+\Z/i, message: "Only letters, numbers, hyphens, and underscores are allowed. Must contain at least one letter." }

  # TODO: Still need to validate username is utf-8
  # https://stackoverflow.com/questions/8635578/how-to-check-whether-the-character-is-utf-8

  # TODO: Might want to ensure username is not an existing UUID (and vice versa?)
  # https://stackoverflow.com/questions/10049047/rails-validate-uniqueness-based-on-another-table
end
