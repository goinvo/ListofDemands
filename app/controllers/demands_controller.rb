class DemandsController < ApplicationController

  before_action :authenticate_user!

  def new
    @demand = current_user.demands.build
  end

  def create
    @demand = current_user.demands.build
    @demand.assign_attributes(create_params)
    @demand.area = current_user.area

    if @demand.save
      redirect_to me_url
    else
      flash[:alert] = "Oops — we couldn't save those changes..."
      render :new
    end
  end

  def show
    @demand = current_user.supported_demands.find(params[:id])
  end

  private

  def create_params
    params.require(:demand).permit(:solution, :problem_text)
  end
end
