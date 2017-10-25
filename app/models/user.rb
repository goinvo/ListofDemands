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
  has_many :demands # own user's demands
  has_many :user_demands # other users' demands

  before_validation :create_profile, on: :create
  before_validation :associate_area, on: :create

  private

  def create_profile
    self.build_profile if profile.blank?
  end

  def associate_area
    return if profile&.zip.blank?

    zip_code = ZipCode.find_by(zip: profile.zip)
    return if zip_code.area.blank?

    self.area = zip_code.area
  end
end
