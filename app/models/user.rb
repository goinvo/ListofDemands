class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_one :profile
  accepts_nested_attributes_for :profile

  before_save :create_profile, on: :create

  private

  def create_profile
    self.build_profile if profile.blank?
  end
end
