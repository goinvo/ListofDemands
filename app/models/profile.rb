class Profile < ApplicationRecord
  include EncodingHelpers

  belongs_to :user
  has_one :zip_code, foreign_key: :zip, primary_key: :zip

  validates :zip, :name, presence: true
  validates :username, format: { with: /\A(?=.*[a-z])[a-z\d\-\_]+\Z/i, message: :invalid_characters }
  # TODO: If for some reason the following uniqueness validation fails to catch
  # an indentical username, the DB should catch it but will throw ActiveRecord::RecordNotUnique
  # Can we rescue from that here somehow and add it as an error on the invalid model?
  validates :username, uniqueness: { case_sensitive: false }
  validate :uuid_exists

  before_create :encode_username
  before_update :encode_username

  def encode_username
    encode_as_utf8!(username)
  end

  def uuid_exists
    if User.where(uuid: username).any?
      errors.add(:username, "has already been taken")
    end
  end
end
