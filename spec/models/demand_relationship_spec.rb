require "rails_helper"

RSpec.describe DemandRelationship do
  before(:each) do
    user = create_arlington_user

    @local_demand = FactoryBot.create(:demand, :local, user: user)
    @state_demand = FactoryBot.create(:demand, :statewide, user: user)
  end

  it "simulanteously creates a relationship and the inverse relationship" do
    @local_demand.related_demands << @state_demand

    expect(@local_demand.related_demands).to include(@state_demand)
    expect(@state_demand.related_demands).to include(@local_demand)
  end

  it "destroys specified relationship and all inverse relationships" do
    @local_demand.related_demands << @state_demand
    @state_demand.related_demands.destroy_all
    @local_demand.reload
    @state_demand.reload

    expect(@state_demand.related_demands).not_to include(@local_demand)
    expect(@local_demand.related_demands).not_to include(@state_demand)
  end
end
