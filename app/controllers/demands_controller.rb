class DemandsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: [:show]
  before_action :require_permission, only: [:edit, :update]

  def new
    @demand = current_user.demands.build
  end

  def create
    form = DemandCreateForm.new(current_user, create_params)

    if form.submit
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
    @demand = Demand.find(params[:id])
  end

  def update
    @demand = Demand.find(params[:id])

    if @demand.update_attributes(update_params)
      render :show
    else
      flash[:alert] = "Oops — we couldn't save those changes..."
      render :edit
    end
  end

  private

  def require_permission
    if !current_user_owns_demand?
      redirect_to root_path
    end
  end

  def create_params
    params.require(:demand).permit(:solution, :problem_text, :topic, :is_statewide)
  end

  def update_params
    params.require(:demand).permit(:solution, :problem_text, :topic, :is_statewide)
  end
end
