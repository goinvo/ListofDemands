class SupportedDemandsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_user_municipality, except: [:show]

  def create
    @demand = find_demand
    current_user.user_demands.create(demand: @demand)
    flash[:info] = "You've demanded #{@demand.name}!"
    redirect_to params[:redirect] || demand_url(@demand)
  end

  def update
    UserDemand.transaction do
      update_params.each_with_index do |user_demand_id, index|
        current_user.user_demands.find(user_demand_id).update_attributes(priority: index + 1)
      end
    end

    if params[:redirect].presence
      redirect_to(me_url)
    else
      head :ok
    end
  end

  private

  def update_params
    params.require(:supported_demands)
  end

  def find_demand
    user_municipality.demands.find(params[:id])
  end
end
