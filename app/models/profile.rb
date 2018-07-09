class Profile < ApplicationRecord
  belongs_to :user
  has_one :zip_code, foreign_key: :zip, primary_key: :zip

  validates :zip, :name, presence: true
  validates :username, uniqueness: true, format: { with: /\A(?=.*[a-z])[a-z\d\-\_]+\Z/i, message: "Only letters, numbers, hyphens, and underscores are allowed. Must contain at least one letter." }
  validate :uuid_exists

  before_create :encode_username
  before_update :encode_username

  def encode_username
    # http://graysoftinc.com/character-encodings/ruby-19s-string
    username.encode!(Encoding.find("UTF-8"), {invalid: :replace, undef: :replace, replace: ""})
  end

  def uuid_exists
    if User.where(uuid: username).any?
      errors.add(:username, "has already been taken")
    end
  end
end
