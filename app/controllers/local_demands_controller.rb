class LocalDemandsController < ApplicationController

  before_action :authenticate_user!, only: [:demand_it]

  def index
    @demands = area.demands
  end

  def show
    @demand = find_demand
  end

  def demand_it
    @demand = find_demand
    current_user.user_demands.create(demand: @demand)
    flash[:info] = "Great, you've demanded #{@demand.name}!"
    redirect_to local_demand_url(@demand)
  end

  private

  def area
    # TODO: handle non authenticated users
    current_user.area
  end
  helper_method :area

  def find_demand
    area.demands.find(params[:id])
  end
end
