class LocalDemandsController < ApplicationController

  before_action :authenticate_user!, only: [:demand_it]
  before_action :ensure_area, except: [:show]

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

  # TODO: extract to a concern
  def ensure_area
    if !user_signed_in? && session[:area_id].blank?
      redirect_to new_area_search_url
    end
  end

  def area
    @area ||= user_signed_in? ? current_user.area : Area.find_by(id: session[:area_id])
  end

  helper_method :area

  def find_demand
    area.demands.find(params[:id])
  end
end
