class Profile < ApplicationRecord
  belongs_to :user
  has_one :zip_code, foreign_key: :zip, primary_key: :zip

  validates :zip, :name, presence: true
  validates :username, uniqueness: true, format: { with: /\A(?=.*[a-z])[a-z\d\-\_]+\Z/i, message: "Only letters, numbers, hyphens, and underscores are allowed. Must contain at least one letter." }

  before_create :encode_username
  before_update :encode_username

  def encode_username
    # http://graysoftinc.com/character-encodings/ruby-19s-string
    username.encode!(Encoding.find("UTF-8"), {invalid: :replace, undef: :replace, replace: ""})
  end

  # TODO: Might want to ensure username is not an existing UUID (and vice versa?)
  # https://stackoverflow.com/questions/10049047/rails-validate-uniqueness-based-on-another-table
end
