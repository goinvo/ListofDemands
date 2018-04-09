class DemandsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @demand = current_user.demands.build
  end

  def create
    @demand = current_user.demands.build
    @demand.assign_attributes(create_params)
    @demand.area = current_user.municipality

    if @demand.save
      redirect_to me_url
    elsif @demand.solution.blank?
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

  private

  def create_params
    params.require(:demand).permit(:solution, :problem_text)
  end
end
