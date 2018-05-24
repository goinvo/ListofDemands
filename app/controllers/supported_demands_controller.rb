class SupportedDemandsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_user_municipality, except: [:show]

  def create
    @demand = find_demand
    current_user.user_demands.create(demand: @demand)
    redirect_to redirect_path
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

  def destroy
    @demand = find_demand
    current_user.user_demands.find_by(demand: @demand)&.destroy
    redirect_to redirect_path
  end

  private

  def update_params
    params.require(:supported_demands)
  end

  def find_demand
    Demand.find(params[:id])
  end

  def redirect_path
    params[:redirect] || demand_url(@demand)
  end
end
