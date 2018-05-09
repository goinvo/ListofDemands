class DemandsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: [:show]

  def new
    @demand = current_user.demands.build
  end

  def create
    form = DemandForm.new(current_user, create_params)

    if form.save
      redirect_to me_url
    elsif form.has_solution?
      flash[:info] = "Okay, we've saved that issue but no demand was created because the proposed solution was empty."
      redirect_to search_url
    else
      flash[:alert] = "Oops — we couldn't save those changes..."
      render :new
    end
  end

  def show
    @demand = Demand.find(params[:id])
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
      render :edit
    end
  end

  private

  def create_params
    params.require(:demand).permit(:solution, :problem_text, :topic, :is_statewide)
  end

  def update_params
    params.require(:demand).permit(:solution, :problem_text, :topic, :is_statewide)
  end
end
