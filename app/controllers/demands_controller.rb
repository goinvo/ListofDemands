class DemandsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: [:show]

  def new
    @demand = current_user.demands.build
  end

  def create
    form = DemandForm.new(current_user, create_params)

    if form.save
      redirect_to redirect_path
    # NOTE: Temporarily removed until we find better option here
    # elsif form.incomplete_demand?
    #   flash[:info] = "Okay, we've saved that issue but no demand was created because the proposed solution was empty."
    #   redirect_to search_url
    elsif !form.demand.valid?
      @demand = form.demand
      render :new
    else
      flash[:alert] = "Oops — we couldn't save those changes..."
      redirect_to new_demand_path
    end
  end

  def show
    @demand = DemandView.new(Demand.find(params[:id]))
  end

  def edit
    @demand = current_user.demands.find(params[:id])
  end

  def update
    form = DemandForm.new(current_user, update_params.merge({id: params[:id]}))

    if form.save
      redirect_to(form.demand)
    else
      flash[:alert] = "Oops — we couldn't save those changes..."
      @demand = form.demand
      render :edit
    end
  end

  private

  def create_params
    params.require(:demand).permit(:solution, :demand_description, :topic, :clone_from, :area => [])
  end

  def update_params
    params.require(:demand).permit(:solution, :demand_description, :topic, :area => [])
  end

  def redirect_path
    params[:redirect] || me_url
  end
end
