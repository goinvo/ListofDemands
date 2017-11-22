class LocalDemandsController < ApplicationController

  before_action :authenticate_user!, only: [:demand_it]
  before_action :ensure_user_area, except: [:show]

  def index
    @demands = user_area.demands
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

  helper_method :area

  def find_demand
    user_area.demands.find(params[:id])
  end
end
