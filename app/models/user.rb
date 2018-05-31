class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :uuid, uniqueness: true

  has_one :profile
  accepts_nested_attributes_for :profile
  delegate :zip_code, to: :profile

  belongs_to :area
  has_many :demands # demands created by this user
  has_many :user_demands # the link to show support for other users' demands
  has_many :supported_demands, through: :user_demands, source: :demand, class_name: "Demand"

  before_validation :create_profile, on: :create
  before_validation :associate_municipality, on: :create

  def municipality
    self.area
  end

  def county
    self.area.county
  end

  def state
    self.area.state
  end

  def associate_municipality
    return if profile&.zip.blank?

    zip_code = ZipCode.find_by(zip: profile.zip)
    return if zip_code.municipality.blank?

    self.area = zip_code.municipality
  end

  def display_name
    profile.name || email.split('@')[0]
  end

  def to_param
    uuid
  end

  private

  def create_profile
    self.build_profile if profile.blank?
  end
end
