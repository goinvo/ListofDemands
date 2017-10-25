class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_one :profile
  accepts_nested_attributes_for :profile
  delegate :zip_code, to: :profile

  belongs_to :area
  has_many :demands # demands created by this user
  has_many :user_demands # the link to show support for other users' demands
  has_many :supported_demands, through: :user_demands, source: :demand, class_name: "Demand"

  before_validation :create_profile, on: :create
  before_validation :associate_area, on: :create

  def associate_area
    return if profile&.zip.blank?

    zip_code = ZipCode.find_by(zip: profile.zip)
    return if zip_code.area.blank?

    self.area = zip_code.area
  end
  
  private

  def create_profile
    self.build_profile if profile.blank?
  end
end
