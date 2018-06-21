class DemandRelationship < ActiveRecord::Base
  belongs_to :demand
  belongs_to :related_demand, class_name: "Demand"

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    self.class.where(inverse_match_options)
  end

  def inverse_match_options
    { related_demand_id: demand_id, demand_id: related_demand_id }
  end
end
