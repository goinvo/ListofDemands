class Area < ApplicationRecord
  has_many :demands
  has_many :problems, through: :demands
  has_many :users

  def to_i
    # TODO: This will have to return all "related" demands once relations are built
    id
  end
end
